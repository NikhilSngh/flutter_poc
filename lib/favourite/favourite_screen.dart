import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Container(
        alignment: Alignment.center,
        color: Colors.indigoAccent,
        width: double.infinity,
        height: double.infinity,
        child: const Text("FAVOURITE PAGE"),
      )),
    );
  }
}
