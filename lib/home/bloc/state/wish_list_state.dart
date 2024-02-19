abstract class WishListState {}

class WishListInitState extends WishListState {}

class WishListSuccess extends WishListState {
  WishListSuccess(this.message, this.isFavourite);

  final String? message;
  final bool isFavourite;
}

class WishListError extends WishListState {
  WishListError(this.message);

  String? message;
}
