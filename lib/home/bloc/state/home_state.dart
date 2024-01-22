import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/utils/default_equatable.dart';


abstract class HomeState extends DefaultEquatable {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie>? carouselList;
  final List<Movie>? gridList;
  final int currentPage;
  final int totalPages;
  final bool isReachedEnd;
  final int? carouselCurrentPage;

  HomeLoaded(this.carouselList, this.gridList, this.currentPage,
      this.totalPages, this.isReachedEnd, this.carouselCurrentPage);

  HomeLoaded copyWith(
      {List<Movie>? carouselList,
      List<Movie>? gridList,
      int? currentPage,
      int? totalPages,
      bool? isReachedEnd,
      int? carouselCurrentPage}) {
    return HomeLoaded(
        carouselList ?? this.carouselList,
        gridList ?? this.gridList,
        currentPage ?? this.currentPage,
        totalPages ?? this.totalPages,
        isReachedEnd ?? this.isReachedEnd,
        carouselCurrentPage ?? this.carouselCurrentPage);
  }

  @override
  List<Object?> get props => [
        carouselList,
        gridList,
        currentPage,
        totalPages,
        isReachedEnd,
        carouselCurrentPage
      ];
}

class HomeError extends HomeState {
  final String errorMessage;

  HomeError(this.errorMessage);
}
