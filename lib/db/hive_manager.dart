import 'dart:io';

import 'package:flutter_poc/home/model/fav_movie_id.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveManager {
  final String _hiveBoxName = "movie";
  late Box hiveMovieBox;

  HiveManager() {
    init();
  }

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FavMovieIdModelAdapter());
    hiveMovieBox = await Hive.openBox<FavMovieIdModel>(_hiveBoxName);
  }

  Future<int> insert(Movie movie) async {
    if (!getMovie(movie.id ?? 0)) {
      return await hiveMovieBox.add(getFavMovieIdModel(movie));
    }
    return 0;
  }


  List<MovieListModel> queryAllFavMovies() {
    List<MovieListModel> list = hiveMovieBox.values.toList().cast<MovieListModel>();

    if (list.isNotEmpty) {
      return list;
    }
    return [];
  }

  List<int> getAllMovieIds() {
    List movieList = hiveMovieBox.values.toList().cast<FavMovieIdModel>();
    List<int> list = movieList.map<int>((obj) => obj.id).toList();
    return list;
  }

  bool getMovie(int id) {
    List movieList = hiveMovieBox.values.toList().cast<FavMovieIdModel>();
    return movieList.map((obj) => obj.id).contains(id);
  }

  Future<void> delete(Movie movie) async {
    return await hiveMovieBox.delete(getFavMovieIdModel(movie));
  }


  FavMovieIdModel getFavMovieIdModel(Movie movie) {
    return FavMovieIdModel(
        title: '',
        overview: '',
        adult: null,
        originalLanguage: '',
        backdropPath: '',
        posterPath: '',
        id: null,
        originalTitle: '',
        mediaType: '',
        genreIds: [],
        popularity: null,
        releaseDate: '',
        video: null,
        voteAverage: null,
        voteCount: null,
        isFavSelected: movie.isFavSelected);
  }

}
