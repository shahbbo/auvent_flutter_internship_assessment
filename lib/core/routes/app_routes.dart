import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/home_screen/prsentation/screens/home_screen.dart';
import '../../features/on_boarding_screen/on_boarding_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onBoardingScreen = '/on_boarding_screen';
  static const String authScreen = '/auth_screen';
  static const String homeScreen = '/home_screen';

  static Map<String, WidgetBuilder> get routes => {
        initialRoute: OnBoarding.builder,
        onBoardingScreen: OnBoarding.builder,
        authScreen: AuthScreen.builder,
        homeScreen: HomeScreen.builder,
      };
}
