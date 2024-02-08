import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:flutter_poc/gen/assets.gen.dart';
import 'package:flutter_poc/helper/app_text_button.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/sl/locator.dart';

@RoutePage()
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sharedInstance = serviceLocator<AppSharedPref>();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.images.onboarding.path,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            padding: const EdgeInsets.only(left: AppPaddingMarginConstant.small,
                right:AppPaddingMarginConstant.small ),
            child: AppElevatedButton(title: AppStrings.proceedToMovieApp, onPressed: () {
              sharedInstance.setBool(key: PrefKey.onBoardingShown, value:true);
              context.router.push(LoginScreenRoute());
            }),
          ),
        ],
      ),
    );
  }
}
