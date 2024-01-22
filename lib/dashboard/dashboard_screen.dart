import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_poc/dashboard/custom_bottom_navigation_widget.dart';
import 'package:flutter_poc/navigation/app_router.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // list of your tab routes
      // routes used here must be declared as children
      // routes of /dashboard
      routes:  [
        HomeScreenRoute(),
        const FavoriteScreenRoute(),
      ],
      transitionBuilder: (context,child,animation)=> FadeTransition(
        opacity: animation,
        // the passed child is technically our animated selected-tab page
        child: child,
      ),
      bottomNavigationBuilder: (_, tabsRouter){
        return CustomBottomNavigationWidget(tabsRouter:tabsRouter);
      },
    );
  }
}