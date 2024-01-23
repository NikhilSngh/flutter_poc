import 'package:flutter_poc/db/table_columns.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



class DBManager {
  final String _databaseName = "ttn.db";
  final int _databaseVersion = 1;
  final String _table = 'favourites';
  late Database _db;

  DBManager() {
    init();
  }

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE if not exists $_table (
            ${TableColumns.id.name} INTEGER PRIMARY KEY,
            ${TableColumns.imageUrl.name} TEXT NULL,
            ${TableColumns.title.name} TEXT NULL,
            ${TableColumns.overview.name} TEXT NULL,
            ${TableColumns.mediaType.name} TEXT NULL,
            ${TableColumns.releaseDate.name} TEXT NULL,
            ${TableColumns.language.name} TEXT NULL,
            ${TableColumns.poster.name} TEXT NULL,
            ${TableColumns.adult.name} INTEGER NULL,
            ${TableColumns.voteAverage.name} REAL NULL,
            ${TableColumns.popularity.name} REAL NULL,
            ${TableColumns.voteCount.name} INTEGER NULL
          )
          ''');
  }

  Future<int> insert(Movie movie) async {
    if(await getMovie(movie.id ?? 0) == null) {
      return await _db.insert(_table, movie.toMap(movie));
    }
    return 0;
  }

  Future<List<Movie>> queryAllMovies() async {
    List<Map> maps = await _db.query(_table);
    if (maps.isNotEmpty) {
      return maps.map((e) => Movie.fromMap(e as Map<String, Object?>)).toList();
    }
    return [];
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $_table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<List<int>> getAllIds() async {
    List<Map> maps = await _db.query(_table,
        columns: [TableColumns.id.name]);
    if (maps.isNotEmpty) {
      return maps.map((e) => e['id'] as int).toList();
    }
    return [];
  }

  Future<Movie?> getMovie(int id) async {
    List<Map> maps = await _db.query(_table,
        where: '${TableColumns.id.name} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Movie.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      _table,
      where: '${TableColumns.id.name} = ?',
      whereArgs: [id]
    );
  }
}
