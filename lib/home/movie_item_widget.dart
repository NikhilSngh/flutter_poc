import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/home/bloc/cubit/wish_list_cubit.dart';
import 'package:flutter_poc/home/bloc/state/wish_list_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/theme/sizes.dart';


class MovieItemWidget extends StatelessWidget {
  MovieItemWidget({
    super.key,
    required this.context,
    required this.movie,
    required this.bannerWidget,
    required this.isGridView,
  });

  final BuildContext context;
  final Movie movie;
  final Widget bannerWidget;
  final bool isGridView;
  bool isfavourite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      cubit.addRemoveWishlist(context, movie,
                          isNeedToAdd: !isfavourite);
                    },
                    child: BlocBuilder<WishListCubit, WishListState>(
                      builder: (context, state) {
                        if (state is WishListSuccess) {
                          isfavourite = true;
                        }
                        return Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.size5),
                            child: Icon(
                              Icons.star_border,
                              color: isfavourite ? Colors.red : Colors
                                  .redAccent,
                            ),
                          ),
                        );
                      },

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
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                          Text(movie.originalLanguage?.toUpperCase() ?? '',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: isGridView ? Sizes.size10 : Sizes.size16,
            ),
            Text(movie.title ?? '',
              maxLines: 1,)
          ],
        ),
      ),
    );
  }
}
