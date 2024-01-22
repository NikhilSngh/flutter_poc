import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationWidget extends StatelessWidget {

  const CustomBottomNavigationWidget({super.key, required this.tabsRouter});

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.white24,
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),
            label: "Favourite",
            backgroundColor: Colors.white24)
      ],
      currentIndex: tabsRouter.activeIndex,
      type: BottomNavigationBarType.shifting,
      onTap: tabsRouter.setActiveIndex,
    );
  }

}


