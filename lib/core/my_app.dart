import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';
import 'package:recipe_app_flutter/home/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //lock orientation to potrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Recipes App",
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: Fonts.regular,),
    );
  }
}
