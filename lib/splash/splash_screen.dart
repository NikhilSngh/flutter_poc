import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/gen/assets.gen.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/sl/locator.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sharedInstance = serviceLocator<AppSharedPref>();
    Timer(
        const Duration(seconds: 3),
        () =>
        {
              sharedInstance.getBool(key: PrefKey.loginStatus) &&
                      checkTimestamp(
                          sharedInstance.getInt(key: PrefKey.timeStamp))
                  ? context.router.push(const AppBottomBarRoute())
                  : sharedInstance.getBool(key: PrefKey.onBoardingShown)
                      ? context.router.push(LoginScreenRoute())
                      : context.router.push(const OnBoardingScreenRoute())
            });
    return Scaffold(
      body: Image.asset(
        Assets.images.splash.path,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  bool checkTimestamp(int timestamp) {
    if (timestamp > 0) {
      var now = DateTime.now();
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      var diff = now.difference(date);
      int time;
      time = diff.inMinutes;

      return time < 50 ? true : false;
    } else {
      return false;
    }
  }
}
