import 'package:blogr_app/controllers_binding.dart';
import 'package:blogr_app/utils/utils.dart';
import 'package:blogr_app/views/articles_screen/articles_screen.dart';
import 'package:blogr_app/views/favorite_screen/favorite_screen.dart';
import 'package:blogr_app/views/home_screen/home_screen.dart';
import 'package:blogr_app/views/login_screen/login_screen.dart';
import 'package:blogr_app/views/popular%20_screen/popular_screen.dart';
import 'package:blogr_app/views/profile_screen/profile_screen.dart';
import 'package:blogr_app/views/root_screen.dart';
import 'package:blogr_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        theme: Themes.light,
        darkTheme: Themes.dark,
        debugShowCheckedModeBanner: false,
        home: RootScreen(),
        initialBinding: ControllersBinding(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          ArticlesScreen.routeName: (context) => ArticlesScreen(),
          PopularScreen.routeName: (context) => const PopularScreen(),
          FavoriteScreen.routeName: (context) => FavoriteScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          // SearchScreen.routeName: (context) => const SearchScreen(),
        });
  }
}
