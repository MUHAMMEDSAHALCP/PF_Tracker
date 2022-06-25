import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:money_management/screens/home/home_screen.dart';
import 'package:money_management/screens/intro_screen/onBoarding_screen.dart';
import 'package:money_management/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => checkLogIn(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: ListTile(
          title: const Text(
            "PF TRACKER",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "CrimsonText",
                fontSize: 35,
                color: kWhite,
                fontWeight: FontWeight.bold),
          ),
          subtitle: AnimatedTextKit(animatedTexts: [
            TypewriterAnimatedText("Personal Finance Tracker",
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                    fontFamily: "Cinzel",
                    fontSize: 20,
                    color: kWhite,
                    fontWeight: FontWeight.bold),
                speed: const Duration(milliseconds: 70)),
          ]),
        ),
      ),
    );
  }
}

void checkLogIn(BuildContext context) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final userLoggedIn = sharedPreferences.getString("keyValue");
  if (userLoggedIn == null || userLoggedIn.isEmpty) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
