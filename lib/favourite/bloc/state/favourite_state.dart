
import 'package:flutter_poc/home/model/movie_list.dart';

abstract class FavouriteState {
  const FavouriteState();

  @override
  List<Object> get props => [];
}
class FavouriteInitState extends FavouriteState { }


class AllWishListState extends FavouriteState {
  AllWishListState(this.wishListItems);
  final List<Movie> wishListItems;

}