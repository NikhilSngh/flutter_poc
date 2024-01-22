import 'package:json_annotation/json_annotation.dart';

part 'movie_list.g.dart';

@JsonSerializable(createToJson: false)
class MovieListModel {
  final int? page;
  @JsonKey(name: "results")
  final List<Movie>? movieList;
  @JsonKey(name: "total_pages")
  final int? totalPages;
  @JsonKey(name: "total_results")
  final int? totalResults;

  const MovieListModel(
      this.page, this.movieList, this.totalPages, this.totalResults);

  factory MovieListModel.fromJson(Map<String, dynamic> data) =>
      _$MovieListModelFromJson(data);
}

@JsonSerializable(createToJson: false)
class Movie {
  final String? title;
  final String? overview;
  final bool? adult;
  @JsonKey(name: "original_language")
  final String? originalLanguage;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;

  @JsonKey(name: "poster_path")
  final String? posterPath;
  final int? id;
  @JsonKey(name: "original_title")
  final String? originalTitle;
  @JsonKey(name: "media_type")
  final String? mediaType;
  @JsonKey(name: "genre_ids")
  final List<int>? genreIds;
  final double? popularity;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final bool? video;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;



  const Movie(
      this.title,
      this.overview,
      this.adult,
      this.originalLanguage,
      this.backdropPath,
      this.posterPath,
      this.id,
      this.originalTitle,
      this.mediaType,
      this.genreIds,
      this.popularity,
      this.releaseDate,
      this.video,
      this.voteAverage,
      this.voteCount);


  factory Movie.fromJson(Map<String, dynamic> data) => _$MovieFromJson(data);

  String getContentRating() {
    return adult! ? "A" : "U/A";
  }
}
