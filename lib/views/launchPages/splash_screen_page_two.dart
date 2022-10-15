import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/constants.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/launchPages/welcome_page.dart';

class SplashScreenTwo extends StatefulWidget {
  static const String path = "/splash";
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  @override
  void initState() {
    super.initState();
    openNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          SafeArea(child: Center(child: Image.asset("assets/moreToLife.png"))),
    );
  }

  Future<void> openNextPage() async {
    await Future.delayed(const Duration(seconds: 1));
    final storage = new FlutterSecureStorage();
    //String value = await storage.read(key: authToken);
    //await storage.deleteAll();
    // var prefs = await SharedPreferences.getInstance();

    if (await storage.read(key: authToken) == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(WelcomePage.path, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginPage.path, (route) => false);
    }
  }
}
