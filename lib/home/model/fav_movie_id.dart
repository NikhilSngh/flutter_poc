import 'package:hive/hive.dart';

part 'fav_movie_id.g.dart';

@HiveType(typeId: 0)
class FavMovieIdModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? overview;
  @HiveField(2)
  bool? adult;
  @HiveField(3)
  String? originalLanguage;
  @HiveField(4)
  String? backdropPath;
  @HiveField(5)
  String? posterPath;
  @HiveField(6)
  int? id;
  @HiveField(7)
  String? originalTitle;
  @HiveField(8)
  String? mediaType;
  @HiveField(9)
  List<int>? genreIds;
  @HiveField(10)
  double? popularity;
  @HiveField(11)
  String? releaseDate;
  @HiveField(12)
  bool? video;
  @HiveField(13)
  double? voteAverage;
  @HiveField(14)
  int? voteCount;
  @HiveField(15)
  bool isFavSelected = false;

  FavMovieIdModel(
      {required this.title,
        required this.overview,
        required this.adult,
        required this.originalLanguage,
        required this.backdropPath,
        required this.posterPath,
        required this.id,
        required this.originalTitle,
        required this.mediaType,
        required this.genreIds,
        required this.popularity,
        required this.releaseDate,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
        required this.isFavSelected});
}
