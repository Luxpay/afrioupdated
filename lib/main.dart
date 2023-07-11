import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luxpay/investment/pages/about_us.dart';
import 'package:luxpay/investment/pages/enter_pin.dart';
import 'package:luxpay/investment/pages/holder.dart';
import 'package:luxpay/investment/pages/interest_record.dart';
import 'package:luxpay/investment/pages/login.dart';
import 'package:luxpay/investment/pages/payment_issues.dart';
import 'package:luxpay/investment/pages/pin_entry_subscribe.dart';
import 'package:luxpay/investment/pages/referrals.dart';
import 'package:luxpay/investment/pages/reward_history.dart';
import 'package:luxpay/investment/pages/support.dart';
import 'package:luxpay/investment/pages/top_up.dart';
import 'package:luxpay/investment/pages/top_up_record.dart';
import 'package:luxpay/investment/pages/transaction_successful.dart';
import 'package:luxpay/investment/pages/withdraw.dart';
import 'package:luxpay/investment/utils/theme_config.dart';
import 'package:luxpay/routes.dart';
import 'package:luxpay/services/local_notification_service.dart';
import 'package:luxpay/views/accounts_subviews/about_luxpay.dart';
import 'package:luxpay/views/accounts_subviews/settings.dart';
import 'package:luxpay/views/accounts_subviews/terms_and_condition.dart';
import 'package:luxpay/views/authPages/change_password.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/views/launchPages/splash_screen_page.dart';
import 'package:luxpay/views/launchPages/splash_screen_page_two.dart';
import 'package:luxpay/views/launchPages/welcome_page.dart';
import 'package:luxpay/views/page_controller.dart';
import 'package:luxpay/views/transfers/bank_transfer.dart';
import 'package:luxpay/views/transfers/wallet_transfer.dart';

import 'views/crowd365/crowd365_dashboard.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  LocalNotificationService.display(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // setupLocator();
  //purgeAll();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
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
      debugShowCheckedModeBanner: false,
      title: 'Luxpay',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        //backgroundColor: Colors.white,
        primarySwatch: colorCustom,
        fontFamily: "Mulish",
      ),
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
      return const AppPageController().getRoute(name: AppPageController.path);
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
    // case Crowd365Packages.path:
    //   return const Crowd365Packages().getRoute();
    case Crowd365Dashboard.path:
      return const Crowd365Dashboard().getRoute();
    case BankTransfers.path:
      return const BankTransfers().getRoute();
    case WalletTransfer.path:
      return const WalletTransfer().getRoute();
    case Routes.login:
      return getRoute(Routes.login, themeify(const InvestmentLogin()));
    case Routes.home:
      return getRoute(Routes.home, themeify(const Holder()));
    case Routes.aboutUs:
      return getRoute(Routes.aboutUs, themeify(const AboutUsPage()));
    case Routes.topUpRecord:
      return getRoute(Routes.topUpRecord, themeify(const TopUpRecord()));
    case Routes.interestRecord:
      return getRoute(Routes.interestRecord, themeify(const InterestRecord()));
    case Routes.support:
      return getRoute(Routes.support, themeify(const SupportPage()));
    case Routes.referrals:
      return getRoute(Routes.referrals, themeify(const Referrals()));
    case Routes.rewardHistory:
      return getRoute(Routes.rewardHistory, themeify(const RewardHistory()));
    case Routes.topUp:
      return getRoute(Routes.topUp, themeify(const TopUp()));
    case Routes.withdraw:
      return getRoute(Routes.withdraw, themeify(const Withdraw()));
    case Routes.paymentIssues:
      return getRoute(Routes.paymentIssues, themeify(const PaymentIssues()));
    case Routes.enterPin:
      return getRoute(Routes.enterPin, themeify(const EnterPin()));
    case Routes.enterPinSubscribe:
      return getRoute(
          Routes.enterPinSubscribe, themeify(const EnterPinSubscribe()));
    case Routes.transactionSuccessful:
      return getRoute(Routes.transactionSuccessful,
          themeify(const TransactionSuccessful()));
  }
  return const Scaffold(
    backgroundColor: Colors.purple,
  ).getRoute();
}

extension GetPath on Widget {
  Route getRoute<T>({Object? arguments, String? name}) {
    print(this.toString());
    return MaterialPageRoute(
      settings: RouteSettings(
        name: name,
        arguments: arguments,
      ),
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: this,
      ),
    );
  }
}

MaterialPageRoute getRoute(String name, Widget child) {
  return MaterialPageRoute(
      builder: (context) => themeify(child),
      settings: RouteSettings(name: name));
}
