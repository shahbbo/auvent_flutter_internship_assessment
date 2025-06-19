import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/di/injections.dart' as di;
import 'core/local/hive_helper.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/navigator_service.dart';
import 'features/auth/data/models/user_model.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<dynamic> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug, // استخدم debug أثناء التطوير
  // );
  await Hive.initFlutter();
  await di.init();

  final userBox = await HiveHelper.init<UserModel>(
    'user',
    adapter: UserModelAdapter(),
  );

  final storedUser = userBox.get('user');

  var settingsBox = await Hive.openBox('settings');

  bool isOnboardingDone = settingsBox.get('onboarding', defaultValue: false);

  String initialRoute = '';

  if (!isOnboardingDone) {
    initialRoute = AppRoutes.onBoardingScreen;
  } else {
    initialRoute =
        storedUser != null ? AppRoutes.homeScreen : AppRoutes.authScreen;
  }

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'mahmoud_shahbo_application',
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          navigatorKey: NavigatorService.navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
