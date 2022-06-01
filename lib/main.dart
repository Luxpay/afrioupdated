import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luxpay/views/accounts_subviews/about_luxpay.dart';
import 'package:luxpay/views/accounts_subviews/settings.dart';
import 'package:luxpay/views/accounts_subviews/terms_and_condition.dart';
import 'package:luxpay/views/authPages/change_password.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/registration_page.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/views/launchPages/splash_screen_page.dart';
import 'package:luxpay/views/launchPages/splash_screen_page_two.dart';
import 'package:luxpay/views/launchPages/welcome_page.dart';
import 'package:luxpay/views/myProfits/crowd365_dashboard.dart';
import 'package:luxpay/views/myProfits/crowd365_packages.dart';
import 'package:luxpay/views/page_controller.dart';
import 'package:luxpay/views/transfers/bank_transfer.dart';
import 'package:luxpay/views/transfers/wallet_transfer.dart';

import 'services/locatorService.dart';

void main() {
  setupLocator();
  purge();
  runApp(ProviderScope(child: MyApp()));
}

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Map<int, Color> color = {
    50: const Color.fromRGBO(215, 10, 10, .1),
    100: const Color.fromRGBO(215, 10, 10, .2),
    200: const Color.fromRGBO(215, 10, 10, .3),
    300: const Color.fromRGBO(215, 10, 10, .4),
    400: const Color.fromRGBO(215, 10, 10, .5),
    500: const Color.fromRGBO(215, 10, 10, .6),
    600: const Color.fromRGBO(215, 10, 10, .7),
    700: const Color.fromRGBO(215, 10, 10, .8),
    800: const Color.fromRGBO(215, 10, 10, .9),
    900: const Color.fromRGBO(215, 10, 10, 1),
  };
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFFD70A0A, color);
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        //backgroundColor: Colors.white,
        primarySwatch: colorCustom, fontFamily: "Mulish"),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name!) {
    case WelcomePage.path:
      return const WelcomePage().getRoute();
    case SplashScreen.path:
      return const SplashScreen().getRoute();
    case LoginPage.path:
      return const LoginPage().getRoute();
    case AppPageController.path:
      return const AppPageController().getRoute();
    case CreatePinPage.path:
      return const CreatePinPage().getRoute(arguments: settings.arguments);
    case SplashScreenTwo.path:
      return const SplashScreenTwo().getRoute();
    case SettingsPage.path:
      return const SettingsPage().getRoute();
    case AboutLuxPay.path:
      return const AboutLuxPay().getRoute();
    case TermsAndConditions.path:
      return const TermsAndConditions().getRoute();
    case ResetPassword.path:
      return const ResetPassword().getRoute();
    case ChangePassword.path:
      return const ChangePassword().getRoute();
    case Crowd365Packages.path:
      return const Crowd365Packages().getRoute();
    case Crowd365Dashboard.path:
      return const Crowd365Dashboard().getRoute();
    case BankTransfer.path:
      return const BankTransfer().getRoute();
    case WalletTransfer.path:
      return const WalletTransfer().getRoute();
  }
  return const Scaffold(
    backgroundColor: Colors.purple,
  ).getRoute(); 
}

extension GetPath on Widget {
  Route getRoute<T>({Object? arguments}) {
    print(this.toString());
    return MaterialPageRoute(
      settings: RouteSettings(
        arguments: arguments,
      ),
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: this,
      ),
    );
  }
}
