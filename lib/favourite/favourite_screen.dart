import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/favourite/bloc/cubit/favourite_cubit.dart';
import 'package:flutter_poc/favourite/bloc/state/favourite_state.dart';
import 'package:flutter_poc/home/bloc/cubit/wish_list_cubit.dart';
import 'package:flutter_poc/home/movie_item_widget.dart';
import 'package:flutter_poc/theme/sizes.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FavouriteCubit()..getWishlist(),
      child: Scaffold(
          appBar: AppBar(title: const Text(AppStrings.favourites)),
          body: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
            if (state is AllWishListState && state.wishListItems.isNotEmpty) {
              return SingleChildScrollView(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: BlocProvider<WishListCubit>(
                        create: (BuildContext context) => WishListCubit(),
                        child: MovieItemWidget(
                          context: context,
                          movie: state.wishListItems[index],
                          bannerWidget: SizedBox(
                            height: Sizes.size90,
                            child: Image.network(
                                "${ApiUrl.IMAGE_BASE_URL}${state.wishListItems[index].backdropPath ?? ''}"),
                          ),
                          isFromHomeView: false,
                          isFavourite: true,
                          favClickAction: () =>
                              {context.read<FavouriteCubit>().getWishlist()},
                        ),
                      ),
                    );
                  },
                  itemCount: state.wishListItems.length,
                ),
              );
            } else {
              return const Center(child: Text(AppStrings.noFavouritesSelected));
            }
          })),
    );
  }
}
