import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/constant/app_icon_constant.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/detail/cubit/detail_wish_list_cubit.dart';
import 'package:flutter_poc/detail/detail_text_icon_widget.dart';
import 'package:flutter_poc/detail/state/detail_wish_list_state.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/theme/sizes.dart';

@RoutePage()
class DetailScreen extends StatelessWidget {
  final Movie movie;
  final Function(bool) favClickAction;

  const DetailScreen(
      {Key? key, required this.movie, required this.favClickAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DetailWishListCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.detail),
            actions: [
              Container(
                padding: const EdgeInsets.only(
                    right: AppPaddingMarginConstant.small,
                    left: AppPaddingMarginConstant.small),
                child: BlocBuilder<DetailWishListCubit, DetailWishListState>(
                  builder: (context, state) {
                    if (state is WishListSuccess) {
                      movie.isFavSelected = state.isFavourite;
                      favClickAction.call(state.isFavourite);
                    }
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<DetailWishListCubit>(context)
                            .addRemoveFavourites(movie,
                                isNeedToAdd: !movie.isFavSelected!);
                      },
                      icon: Icon(
                        AppIconConstant.favorite,
                        color: movie.isFavSelected! ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPaddingMarginConstant.small),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: Sizes.size200,
                  child: Image.network(
                    ApiUrl.IMAGE_BASE_URL + movie.backdropPath.toString(),
                    fit: BoxFit.contain,
                    height: Sizes.size200,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: AppPaddingMarginConstant.extraSmall),
                  child: Text(movie.title.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.size15,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                    margin: const EdgeInsets.only(
                        top: AppPaddingMarginConstant.extraSmall),
                    child: Text(movie.overview.toString())),
                Container(
                  margin: const EdgeInsets.only(
                      top: AppPaddingMarginConstant.extraSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailTextIconWidget(
                          iconData: Icons.no_adult_content,
                          text: movie.adult.toString()),
                      DetailTextIconWidget(
                          iconData: Icons.language,
                          text: movie.originalLanguage.toString()),
                      DetailTextIconWidget(
                          iconData: Icons.aspect_ratio,
                          text: movie.popularity.toString()),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: AppPaddingMarginConstant.extraSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(AppStrings.releaseDate,
                              style: TextStyle(
                                  color: Colors.black, fontSize: Sizes.size18)),
                          Center(
                            child: Text(movie.releaseDate.toString(),
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: Sizes.size15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(AppStrings.rating,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size18,
                              )),
                          Center(
                            child: Text(movie.voteAverage.toString(),
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: Sizes.size15,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: AppPaddingMarginConstant.small),
                  child: DetailTextIconWidget(
                      iconData: Icons.perm_media_outlined,
                      text: movie.mediaType.toString()),
                ),
              ]),
            ),
          )),
    );
  }
}
