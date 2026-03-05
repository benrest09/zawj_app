import 'package:flutter/material.dart';
import 'package:zawj_app/database/preference.dart';
import 'package:zawj_app/extention/navigator.dart';
import 'package:zawj_app/loginpage.dart';
import 'package:zawj_app/onboarding_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    await Future.delayed(Duration(seconds: 3));
    bool? isLogin = await PreferenceHandler.getIsLogin();

    if (!mounted) return;
    if (isLogin == true) {
      context.pushAndRemoveAll(LoginPage());
    } else {
      context.pushAndRemoveAll(OnboardingScreen1());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/zawj.png", width: 150, height: 150),
          ],
        ),
      ),
    );
  }
}
