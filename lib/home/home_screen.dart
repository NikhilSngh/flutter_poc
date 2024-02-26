import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/home/bloc/cubit/home_cubit.dart';
import 'package:flutter_poc/home/bloc/cubit/wish_list_cubit.dart';
import 'package:flutter_poc/home/bloc/state/home_state.dart';
import 'package:flutter_poc/home/carousel_view.dart';
import 'package:flutter_poc/home/movie_item_widget.dart';
import 'package:flutter_poc/home/repository/home_repository.dart';
import 'package:flutter_poc/theme/sizes.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  var isFav = false;

  HomeScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) =>
              HomeCubit(HomeRepository())..loadFirstTwoPageOfMovie(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return state is HomeLoaded
                ? SingleChildScrollView(
                    controller: initScrollListener(context),
                    padding: const EdgeInsets.only(bottom: Sizes.size16),
                    child: Column(
                      children: [
                        CarouselView((state.carouselList!.length > 10)
                            ? state.carouselList!.sublist(0, 10)
                            : []),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.3, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return BlocProvider<WishListCubit>(
                              create: (BuildContext context) =>
                                  WishListCubit(),
                              child: MovieItemWidget(
                                movie: state.gridList![index],
                                bannerWidget: Image.network(
                                    "${ApiUrl.IMAGE_BASE_URL}${state.gridList?[index].backdropPath ?? ''}"),
                                isFromHomeView: true, isClicked: () {  },
                              ),
                            );
                          },
                          itemCount: state.gridList?.length,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Sizes.size16),
                          child: state.isReachedEnd
                              ? const CircularProgressIndicator()
                              : Container(),
                        )
                      ],
                    ),
                  )
                : state is HomeLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state is HomeError
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_sharp,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  height: Sizes.size16,
                                ),
                                Text(state.errorMessage)
                              ],
                            ),
                          )
                        : Container();
          }),
        ),
      ),
    );
  }

  ScrollController initScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<HomeCubit>(context).loadMore();
      }
    });

    return _scrollController;
  }
}
