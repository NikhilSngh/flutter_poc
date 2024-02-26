import 'package:json_annotation/json_annotation.dart';

part 'movie_list.g.dart';

@JsonSerializable()
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

@JsonSerializable()
class Movie {
   String? title;
   String? overview;
   bool? adult;
  @JsonKey(name: "original_language")
   String? originalLanguage;
  @JsonKey(name: "backdrop_path")
   String? backdropPath;
  @JsonKey(name: "poster_path")
   String? posterPath;
   int? id;
  @JsonKey(name: "original_title")
   String? originalTitle;
  @JsonKey(name: "media_type")
   String? mediaType;
  @JsonKey(name: "genre_ids")
   List<int>? genreIds;
   double? popularity;
  @JsonKey(name: "release_date")
   String? releaseDate;
   bool? video;
  @JsonKey(name: "vote_average")
   double? voteAverage;
  @JsonKey(name: "vote_count")
   int? voteCount;
   @JsonKey(includeFromJson: false)
   bool isFavSelected = false;

   Movie(
      {this.title,
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
      this.voteCount,
      this.isFavSelected = false});


  factory Movie.fromJson(Map<String, dynamic> data) => _$MovieFromJson(data);

  String getContentRating() {
    return adult! ? "A" : "U/A";
  }


  Movie.fromMap(Map<String, Object?> map) {
    backdropPath = map['imageUrl'] as String;
    adult = map['adult'] == 1;
    id = map['id'] as int;
    title = map['title'] as String;
    overview = map['overview'] as String;
    mediaType = map['mediaType'] as String;
    releaseDate = map['releaseDate'] as String;
    voteAverage = (map['voteAverage'] as num?)?.toDouble();
    popularity = (map['popularity'] as num?)?.toDouble();
    voteCount = map['voteCount'] as int;
    originalLanguage = map['language'] as String;
    posterPath = map['poster'] as String;
    isFavSelected = true;
  }

  Map<String, Object?> toMap(Movie instance) => <String, Object?>{
    'imageUrl': instance.backdropPath,
    'adult': (instance.adult == true) ? 1 : 0,
    'id': instance.id,
    'title': instance.title,
    'overview': instance.overview,
    'mediaType': instance.mediaType,
    'releaseDate': instance.releaseDate,
    'voteCount': instance.voteCount,
    'voteAverage': instance.voteAverage,
    'language': instance.originalLanguage,
    'poster': instance.posterPath,
    'popularity': instance.popularity,
    'isFavSelected' : instance.isFavSelected
  };
}
