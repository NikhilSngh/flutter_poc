import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/account/account_screen.dart';
import 'package:flutter_poc/constant/app_icon_constant.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/favourite/bloc/cubit/favourite_cubit.dart';
import 'package:flutter_poc/favourite/favourite_screen.dart';
import 'package:flutter_poc/home/bloc/cubit/home_cubit.dart';
import 'package:flutter_poc/home/home_screen.dart';
import '../home/repository/home_repository.dart';

@RoutePage()
class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});
  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    BlocProvider(
        create: (context) => HomeCubit(HomeRepository()),
        child: HomeScreen()),
    BlocProvider(
        create: (context) => FavouriteCubit(), child: FavoriteScreen()),
    const AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(AppIconConstant.home), label: AppStrings.home),
        BottomNavigationBarItem(
            icon: Icon(AppIconConstant.favorite), label: AppStrings.favourites),
        BottomNavigationBarItem(
            icon: Icon(AppIconConstant.accountCircleSharp), label: AppStrings.account),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: _bottomBar());
  }
}
