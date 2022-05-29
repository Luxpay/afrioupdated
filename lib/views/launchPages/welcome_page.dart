import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:luxpay/services/authService.dart';
import 'package:luxpay/services/locatorService.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/registration_page.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> titleList = [
  'Safe & Secure',
  'Crowdfunding & Donations',
  'Smart Lifestyle & Payments'
];

final List<String> bodyList = [
  'We offer a secure platform while enabling a safe outlet for all your financial activities.',
  'Keep track of your donations, fundraising, and crowdfunding from one platform.',
  'Make instant payments at will while maintaining a convenient lifestyle. '
];

final List<Widget> imageSliders = [
  const AssetImage('assets/vault-rafiki.png'),
  const AssetImage('assets/analytics-rafiki.png'),
  const AssetImage('assets/payment-Information-rafiki.png'),
]
    .map((item) => Image(
          image: item,
          fit: BoxFit.cover,
        ))
    .toList();

double? width, height;

class WelcomePage extends StatefulWidget {
  static const String path = "/onboard";
  final String? title;

  const WelcomePage({Key? key, this.title}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  static Color? _primaryColour;
  static Color? _accentColour;
  late String _title;
  late String _body;
  final LocalAuthenticationService? _localAuth =
      locator<LocalAuthenticationService>();
  var localAuth = LocalAuthentication();
  bool? didAuthenticate;
  late SharedPreferences prefs;
  // RestDatasource api = new RestDatasource();
  String _btnText = "Next";
  bool showSkip = true;
  CarouselController carouselController = CarouselControllerImpl();

  @override
  void initState() {
    super.initState();
    _title = titleList.first;
    _body = bodyList.first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _primaryColour = Theme.of(context).primaryColor;
    _accentColour = Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: height,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Spacer(),
                        CarouselSlider(
                          items: imageSliders,
                          carouselController: carouselController,
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              // height: 270.58,
                              aspectRatio: 1.5,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                  _title = titleList[index];
                                  _body = bodyList[index];
                                  if (_current == 3) {
                                    showSkip = false;
                                    _btnText = "Get Started";
                                  }
                                });
                              }),
                        ),
                        SizedBox(
                          height: height * 0.024,
                        ),
                        //Label
                        Padding(
                          padding: const EdgeInsets.only(left: 20.72),
                          child: Text(
                            _title,
                            style: TextStyle(
                              // fontFamily: "Mulish",
                              fontSize: 22,
                              color: HexColor("#1E1E1E"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        //
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.72),
                          child: Text(
                            _body,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#1B2124")),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.024,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: titleList.map((url) {
                            int index = titleList.indexOf(url);
                            return Container(
                              width: _current == index ? 40.0 : 12.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                                color: _current == index
                                    ? HexColor("#D70A0A")
                                    : HexColor("#D70A0A").withOpacity(0.1),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 7,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(children: [
                        InkWell(
                            onTap: () async {
                              // _orthoUser = await MyConstants.getOrthoUser();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const RegistrationPage()));

                               Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreateAccount()
                                ),
                              );
                            },
                            child: luxButton(HexColor("#D70A0A"), Colors.white,
                                "Get Started", 350)),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Text(
                            "LOG IN",
                            style: TextStyle(
                                color: HexColor("#D70A0A"),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ])),
                ]),
              )
            ],
          ),
        ),
      ),
      backgroundColor: HexColor("#FFFFFF"),
    );
  }
}
