import 'package:blogr_app/utils/themeService_util.dart';
import 'package:blogr_app/utils/themes_util.dart';
import 'package:blogr_app/views/logo_screen/logo_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers_binding.dart';
import 'views/articles_screen/articles_screen.dart';
import 'views/favorite_screen/favorite_screen.dart';
import 'views/home_screen/home_screen.dart';
import 'views/login_screen/login_screen.dart';
import 'views/popular _screen/popular_screen.dart';
import 'views/profile_screen/profile_screen.dart';
import 'views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await GetStorage.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: MyThemes.light,
        darkTheme: MyThemes.dark,
        themeMode: ThemeService().theme,
        debugShowCheckedModeBanner: false,
        home: LogoScreen(),
        initialBinding: ControllersBinding(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          ArticlesScreen.routeName: (context) => ArticlesScreen(),
          PopularScreen.routeName: (context) => const PopularScreen(),
          FavoriteScreen.routeName: (context) => FavoriteScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
        });
  }
}
