import 'package:flutter/material.dart';
import '../../utils/hexcolor.dart';
import 'splash_screen_page_two.dart';

class SplashScreen extends StatefulWidget {
  static const String path = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showLogin = true;
  @override
  void initState() {
    super.initState();
    openSecondSplash();
    // fcmToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#D70A0A"),
      body: SafeArea(child: Center(child: Image.asset("assets/lp.png"))),
    );
  }

  Future<void> openSecondSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SplashScreenTwo.path, (route) => false);
  }
}
