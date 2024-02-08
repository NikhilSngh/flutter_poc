import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/db/db_manager.dart';
import 'package:flutter_poc/detail/state/detail_wish_list_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/sl/locator.dart';

class DetailWishListCubit extends Cubit<DetailWishListState> {
  DetailWishListCubit() : super(WishListInitState());

  void addRemoveFavourites(Movie movie,
      {bool isNeedToAdd = true}) async {
    var db = serviceLocator<DBManager>();
    print(isNeedToAdd);
    if (isNeedToAdd) {
      var result = await db.insert(movie);
      if (result > 0) {
        print("AddedSuccess");
        emit(WishListSuccess("successfullyAdded", true));
      } else {
        print("AddedError");
        emit(WishListError("dbError"));
      }
    } else {
      var result = await db.delete(movie.id ?? 0);
      if (result > 0) {
        print("removedSuccess");
        emit(WishListSuccess("successfullyRemoved", false));
      } else {
        print("removederror");
        emit(WishListError("dbError"));
      }
    }
  }
}
