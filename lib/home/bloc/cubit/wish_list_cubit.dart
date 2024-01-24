import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/db/db_manager.dart';
import 'package:flutter_poc/home/bloc/state/wish_list_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/sl/locator.dart';


class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitState());


  void addRemoveWishlist(BuildContext context, Movie movie,
      {bool isNeedToAdd = true}) async {
    var db = serviceLocator<DBManager>();
    if (isNeedToAdd) {
      var result = await db.insert(movie);
      if (result > 0) {
        if (context.mounted) emit(WishListSuccess("successfullyAdded",true));
      } else {
        if (context.mounted) emit(WishListError("dbError"));
      }
    } else {
      var result = await db.delete(movie.id ?? 0);
      if (result > 0) {
        if (context.mounted) {
          emit(WishListSuccess("successfullyRemoved",false));
        }

      } else {
        if (context.mounted)  emit(WishListError("dbError"));
      }
    }
  }
}