import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/home/bloc/state/wish_list_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/sl/locator.dart';


class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitState());


  void addRemoveWishlist(BuildContext context, Movie movie) async {
    var wishListIds = serviceLocator<AppSharedPref>().getList<Movie>('favouriteList', Movie.fromJson);
    if (!movie.isFavSelected) {
      wishListIds.add(movie);
      var result =  serviceLocator<AppSharedPref>().saveList('favouriteList',
          wishListIds.map((fav) => fav.toJson()).toList());
      if (await result) {
        if (context.mounted) emit(WishListSuccess("successfullyAdded",true));
      } else {
        if (context.mounted) emit(WishListError("dbError"));
      }
    } else {
      wishListIds.removeWhere((element) => element.id == movie.id);
      var result = serviceLocator<AppSharedPref>().saveList('favouriteList', wishListIds);
      if (await result) {
        if (context.mounted) {
          emit(WishListSuccess("successfullyRemoved",false));
        }
      } else {
        if (context.mounted)  emit(WishListError("dbError"));
      }
    }
  }
}