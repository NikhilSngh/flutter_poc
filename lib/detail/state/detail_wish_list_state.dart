abstract class DetailWishListState {}

class WishListInitState extends DetailWishListState {}

class WishListSuccess extends DetailWishListState {
  WishListSuccess(this.message, this.isFavourite);

  final String? message;
  final bool isFavourite;
}

class WishListError extends DetailWishListState {
  WishListError(this.message);

  String? message;
}
