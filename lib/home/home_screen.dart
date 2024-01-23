
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/home/bloc/cubit/home_cubit.dart';
import 'package:flutter_poc/home/bloc/cubit/wish_list_cubit.dart';
import 'package:flutter_poc/home/bloc/state/home_state.dart';
import 'package:flutter_poc/home/movie_item_widget.dart';
import 'package:flutter_poc/home/repository/home_repository.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/theme/sizes.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
     HomeScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(HomeRepository())..loadFirstTwoPageOfMovie(),
        ),
        BlocProvider<WishListCubit>(
          create: (BuildContext context) => WishListCubit(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return state is HomeLoaded
                ? SingleChildScrollView(
              controller: initScrollListener(context),
              padding: const EdgeInsets.only(bottom: Sizes.size16),
              child: Column(
                children: [
                  Container(
                    height: Sizes.size320,
                    child: PageView.builder(
                        controller:
                        context.read<HomeCubit>().pageController,
                        onPageChanged: (int page) {
                          BlocProvider.of<HomeCubit>(context)
                              .updateDotIndicator(page);
                        },
                        itemCount: state.carouselList?.length,
                        itemBuilder: (context, index) {
                          return MovieItemWidget(
                              context: context,
                              movie: state.carouselList![index],
                              bannerWidget: SizedBox(
                                  height: Sizes.size250,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    "${ApiUrl.IMAGE_BASE_URL}${state.carouselList![index].backdropPath ?? ''}",
                                    fit: BoxFit.cover,
                                  )),
                              isGridView: false);
                        }),
                  ),
                  SizedBox(
                    height: Sizes.size20,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                          const EdgeInsets.all(Sizes.size5),
                          child: SizedBox(
                              height: Sizes.size0,
                              child:
                              state.carouselCurrentPage == index
                                  ? const Icon(
                                Icons.circle,
                                size: Sizes.size8,
                                color: Colors.blue,
                              )
                                  : const Icon(
                                Icons.circle_outlined,
                                size: Sizes.size8,
                                color: Colors.blueAccent,
                              )),
                        );
                      },
                      itemCount: state.carouselList?.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Container(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.3, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            context.router.push(DetailScreenRoute(movie: state.gridList![index]));
                          },
                          child: MovieItemWidget(
                              context: context,
                              movie: state.gridList![index],
                              bannerWidget: Image.network(
                                  "${ApiUrl.IMAGE_BASE_URL}${state.gridList?[index].backdropPath ?? ''}"),
                              isGridView: true),
                        );
                      },
                      itemCount: state.gridList?.length,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: Sizes.size16),
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
                  const Icon(Icons.error_sharp,
                  color: Colors.red,),
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
