import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/account/account_screen.dart';
import 'package:flutter_poc/bottombar/bottom_bar.dart';
import 'package:flutter_poc/detail/detail_screen.dart';
import 'package:flutter_poc/favourite/favourite_screen.dart';
import 'package:flutter_poc/home/home_screen.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/login/login_screen.dart';
import 'package:flutter_poc/signup/signup_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(page: AppBottomBarRoute.page, initial: false,),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: FavoriteScreenRoute.page),
        AutoRoute(page: DetailScreenRoute.page),
        AutoRoute(page: LoginScreenRoute.page, initial: true),
        AutoRoute(page: SignupScreenRoute.page, initial: false),
        AutoRoute(page: AccountScreenRoute.page)
      ];
}