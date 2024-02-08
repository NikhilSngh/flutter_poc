import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/db/db_manager.dart';
import 'package:flutter_poc/home/bloc/state/home_state.dart';
import 'package:flutter_poc/home/repository/home_repository.dart';
import 'package:flutter_poc/sl/locator.dart';

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
        List<int> ids = await serviceLocator<DBManager>().getAllIds();
        final dataList = await _homeRepository.getMoviesData(pageNo);
        final dataList2 = await _homeRepository.getMoviesData(++pageNo);

        emit(HomeLoaded(dataList.movieList, dataList2.movieList,
            dataList.page ?? 1, dataList.totalPages ?? -1, false, 0, ids));
      } else {
        if (state is HomeLoaded) {
          var homeLoadedState = state as HomeLoaded;
          emit(homeLoadedState.copyWith(isReachedEnd: true));

          List<int> ids = await serviceLocator<DBManager>().getAllIds();
          final dataList = await _homeRepository.getMoviesData(pageNo);

          homeLoadedState.gridList?.addAll(dataList.movieList ?? []);
          emit((state as HomeLoaded).copyWith(
              gridList: homeLoadedState.gridList,
              currentPage: dataList.page,
              totalPages: dataList.totalPages,
              isReachedEnd: false,
              favorite: ids));
        }
      }
    } on Exception catch (e) {
      emit(HomeError('Failed to load data: ${e.toString()}'));
    }
  }


  Future<void> refreshData() async {

    List<int> ids = await serviceLocator<DBManager>().getAllIds();

    try {
      var  list = (state as HomeLoaded).gridList;
      emit((state as HomeLoaded).copyWith(gridList: []));
      emit((state as HomeLoaded).copyWith(gridList: list,favorite: ids));
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
