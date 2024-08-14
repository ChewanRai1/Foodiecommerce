import 'package:flaviourfleet/features/auth/presentation/view/login_view.dart';
import 'package:flaviourfleet/theme/theme_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';

import 'navigator_key/navigator_key.dart';
import 'themes/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(shakeDetectionServiceProvider);
    return MaterialApp(
      // theme: getThemeData(),
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.navigatorKey,
      home: const SplashView(),
      routes: {
        '/login': (context) => const LoginView(),
      },
    );
  }
}
