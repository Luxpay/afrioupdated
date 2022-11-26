import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/views/account.dart';
import 'package:luxpay/views/finances.dart';
import 'package:luxpay/views/home.dart';
import 'package:luxpay/views/referrer.dart';
import '../utils/hexcolor.dart';

class AppPageController extends StatefulWidget {
  static const String path = "appPageController";
  const AppPageController({Key? key}) : super(key: key);

  @override
  _AppPageControllerState createState() => _AppPageControllerState();
}

class _AppPageControllerState extends State<AppPageController> {
  int _currentIndex = 0;
  static const int home = 0;
  static const int finance = 1;
  static const int rewards = 2;
  static const int account = 3;
  Widget currentPage = const HomePage();

  //SystemNavigator.pop()

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: HexColor("#D70A0A"),
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: HexColor("#FBFBFB"),
        bottomNavigationBar: _getBottomNav(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FloatingActionButton(
            // heroTag: "float",
            backgroundColor: HexColor("#D70A0A"),
            child: const Icon(
              IconlyBold.scan,
              size: 30.32,
            ),
            onPressed: () => {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(child: currentPage),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (_currentIndex) {
        case home:
          currentPage = const HomePage();
          break;
        case finance:
          currentPage = const FinancesPage();
          break;
        case rewards:
          //currentPage = const RewardsPage();
          currentPage = const ReferAndEarn();
          break;
        case account:
          currentPage = const AccountPage();
          break;
      }
    });
  }

  BottomNavigationBar _getBottomNav() {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon:
              Icon(_currentIndex == home ? IconlyBold.home : IconlyLight.home),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Icon(_currentIndex == finance
              ? IconlyBold.activity
              : IconlyLight.activity),
          label: "Finance"),
    ].toList(growable: true);
    items.add(BottomNavigationBarItem(
        icon:
            Icon(_currentIndex == rewards ? IconlyBold.bag2 : IconlyLight.bag2),
        label: "Refer&Earn"));
    items.add(BottomNavigationBarItem(
        icon: Icon(_currentIndex == account
            ? IconlyBold.profile
            : IconlyLight.profile),
        label: "Account"));

    return BottomNavigationBar(
      items: items,
      type: BottomNavigationBarType.fixed,
      onTap: onTabTapped,
      currentIndex: _currentIndex,
    );
  }
}
