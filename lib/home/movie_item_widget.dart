import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_icon_constant.dart';
import 'package:flutter_poc/home/bloc/cubit/wish_list_cubit.dart';
import 'package:flutter_poc/home/bloc/state/wish_list_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/theme/sizes.dart';

class MovieItemWidget extends StatelessWidget with ChangeNotifier {
  MovieItemWidget({
    super.key,
    required this.movie,
    required this.bannerWidget,
    required this.isFromHomeView,
  }) {
    _wishlist = ValueNotifier<bool>(movie.isFavSelected);
  }

  final Movie movie;
  final Widget bannerWidget;
  final bool isFromHomeView;

  late ValueNotifier<bool>? _wishlist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router
            .push(
          DetailScreenRoute(
              movie: movie,
              contextHome: context),
        )
            .then((value) {
          _wishlist?.value = movie.isFavSelected;
          _wishlist?.notifyListeners();
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  bannerWidget,
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        final cubit = context.read<WishListCubit>();
                        cubit.addRemoveWishlist(context, movie);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.size5),
                          child: BlocBuilder<WishListCubit, WishListState>(
                              builder: (context, state) {
                            if (state is WishListSuccess) {
                              movie.isFavSelected = !movie.isFavSelected;
                            }
                            return ValueListenableBuilder(
                              valueListenable: _wishlist!,
                              builder: (context, value, _) {
                                return Icon(
                                  AppIconConstant.favorite,
                                  color: movie.isFavSelected
                                      ? Colors.red
                                      : Colors.grey,
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: Sizes.size16, right: Sizes.size16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.getContentRating(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(movie.originalLanguage?.toUpperCase() ?? '',
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Sizes.size4,
              ),
              Text(movie.title ?? '',
                  maxLines: 1, style: Theme.of(context).textTheme.titleSmall)
            ],
          ),
        ),
      ),
    );
  }
}
