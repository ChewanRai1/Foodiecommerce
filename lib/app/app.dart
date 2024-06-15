import 'package:flaviourfleet/screen/splash_screen.dart';

import '../features/splash/presentation/view/splash_view.dart';
import '../screen/login_screen.dart';
import '../screen/register_screen.dart';
import 'package:flutter/material.dart';

import 'navigator_key/navigator_key.dart';
import 'themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flavour Fleet',
      theme: AppTheme.getApplicationTheme(false),
      home: const SplashView(),
    );
  }
}
