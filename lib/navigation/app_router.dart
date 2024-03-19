import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/account/account_screen.dart';
import 'package:flutter_poc/bottombar/bottom_bar.dart';
import 'package:flutter_poc/detail/detail_screen.dart';
import 'package:flutter_poc/editaccount/edit_account_screen.dart';
import 'package:flutter_poc/favourite/favourite_screen.dart';
import 'package:flutter_poc/home/home_screen.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/login/login_screen.dart';
import 'package:flutter_poc/onboarding/onboarding_screen.dart';
import 'package:flutter_poc/signup/signup_screen.dart';
import 'package:flutter_poc/splash/splash_screen.dart';


part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(page: AppBottomBarRoute.page,path: "/dashboard",
         children: [
           AutoRoute(page: HomeScreenRoute.page,path:"home"),
           AutoRoute(page: FavoriteScreenRoute.page,path:"favourite"),
           AutoRoute(page: AccountScreenRoute.page,path:"account"),
      ]),
        AutoRoute(page: DetailScreenRoute.page,path:"/detail"),
        AutoRoute(page: LoginScreenRoute.page, initial: false,path:"/login"),
        AutoRoute(page: SignupScreenRoute.page, initial: false,path:"/signup"),
        AutoRoute(page: EditAccountRoute.page,path:"/editAccount"),
        AutoRoute(page: SplashScreenRoute.page, initial: true,path:"/splash"),
        AutoRoute(page: OnBoardingScreenRoute.page,path:"/onboarding")
      ];
}