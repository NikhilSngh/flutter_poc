import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/dashboard/dashboard_screen.dart';
import 'package:flutter_poc/detail/detail_screen.dart';
import 'package:flutter_poc/favourite/favourite_screen.dart';
import 'package:flutter_poc/home/home_screen.dart';
import 'package:flutter_poc/home/model/movie_list.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: DashboardScreenRoute.page,initial: true,
    children: [
      AutoRoute(page: HomeScreenRoute.page),
      AutoRoute(page:FavoriteScreenRoute.page )
    ]
    ),
    AutoRoute(page: DetailScreenRoute.page)
  ];
}