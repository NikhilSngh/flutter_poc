import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/db/db_manager.dart';
import 'package:flutter_poc/favourite/bloc/state/favourite_state.dart';
import 'package:flutter_poc/sl/locator.dart';


class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitState()) {
    getWishlist();
  }

  void getWishlist() async {
    var db = serviceLocator<DBManager>();
    var result = await db.queryAllMovies();
    emit(AllWishListState(result));
  }
}