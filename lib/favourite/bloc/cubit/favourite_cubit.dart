import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/favourite/bloc/state/favourite_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/sl/locator.dart';


class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitState()) {
    getWishlist();
  }

  void getWishlist() async {
    var result = serviceLocator<AppSharedPref>().getList<Movie>('favouriteList', Movie.fromJson);
    result.forEach((element) {
      element.isFavSelected = true;
    });
    emit(AllWishListState(result));
  }
}