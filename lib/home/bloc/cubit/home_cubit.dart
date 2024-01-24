import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/home/bloc/state/home_state.dart';
import 'package:flutter_poc/home/repository/home_repository.dart';



class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  final PageController pageController = PageController();

  HomeCubit(this._homeRepository) : super(HomeLoading());

  void loadFirstTwoPageOfMovie() {
    loadMoviesData(1);
  }

  Future<void> loadMoviesData(int pageNo) async {
    try {
      if (pageNo == 1) {
        final dataList = await _homeRepository.getMoviesData(pageNo);
        final dataList2 = await _homeRepository.getMoviesData(++pageNo);

        emit(HomeLoaded(dataList.movieList, dataList2.movieList,
            dataList.page ?? 1, dataList.totalPages ?? -1, false, 0));
      } else {
        if (state is HomeLoaded) {
          var homeLoadedState = state as HomeLoaded;
          emit(homeLoadedState.copyWith(isReachedEnd: true));

          final dataList = await _homeRepository.getMoviesData(pageNo);

          homeLoadedState.gridList?.addAll(dataList.movieList ?? []);
          emit((state as HomeLoaded).copyWith(
              gridList: homeLoadedState.gridList,
              currentPage: dataList.page,
              totalPages: dataList.totalPages,
              isReachedEnd: false));
        }
      }
    } on Exception catch (e) {
      emit(HomeError('Failed to load data: ${e.toString()}'));
    }
  }

  void loadMore() {
    if (state is HomeLoaded) {
      var currentState = state as HomeLoaded;

      if (!currentState.isReachedEnd &&
          currentState.totalPages >= currentState.currentPage) {
        int currentPage = currentState.currentPage;
        loadMoviesData(++currentPage);
      }
    }
  }
}
