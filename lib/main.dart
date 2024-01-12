import 'package:flutter/material.dart';
import 'package:flutter_poc/navigation/app_router.dart';
import 'package:flutter_poc/sl/locator.dart';

import 'package:flutter_poc/theme/ui_theme.dart';

void main() {
  setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: UiTheme.theme,
      darkTheme: UiTheme.darkTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
