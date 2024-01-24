
abstract class  WishListState {}

class WishListInitState extends WishListState { }

class WishListSuccess extends WishListState {
  WishListSuccess(this.message,this.isFavourite);
  String? message;
  bool isFavourite;
}
class WishListError extends WishListState {
  WishListError(this.message);
  String? message;
}