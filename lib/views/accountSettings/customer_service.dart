import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/aboutUser.dart';
import '../../models/customer_care_email.dart';
import '../../models/customer_care_phone.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/getDeviceInfo.dart';
import '../../widgets/methods/showDialog.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  String? errors;

  String? customerCareNumber, customerCareEmail;

  String? username;

  _launchURL() async {
    var url = customerCareNumber;
    if (await canLaunch(url!)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLEmail() async {
    var url =
        "mailto:$customerCareEmail?subject=${Uri.encodeFull("Luxpay User Feed Back")}&body=${Uri.encodeFull("Luxpay")}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aboutUser();
      customerCare();
      customerServiceEmail();
    });
  }

  @override
  Widget build(BuildContext context) {
    String usernameCapital = capitalizeAllWord(username ?? "loading...");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  // margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {Navigator.maybePop(context)},
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2,
                      ),
                      const Text(
                        "Customer Service",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 100,
                    // color: Colors.red,
                    margin: EdgeInsets.only(top: 130, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Image.asset(
                            "assets/cservice.png",
                            scale: 0.6,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi $usernameCapital",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                                "You can contact me through any of the\nmeans below")
                          ],
                        ))
                      ],
                    ))),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    margin: EdgeInsets.only(top: 220, left: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _launchURL();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(width: 1, color: grey3)),
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(IconlyLight.chat, color: Colors.blue),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "Live Chat",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    canLaunch("09166633445")
                                        .then((value) => {
                                              print("can launch $value"),
                                            })
                                        .catchError((e) => {print(e)});
                                    launch("tel://09166633445");
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: HexColor("#D70A0A"),
                                    ),
                                    child: Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              "Call",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _launchURLEmail();
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: HexColor("#D70A0A"),
                                    ),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        customerCareEmail ?? "loading..",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Please note we are available;",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Divider(
                              color: grey5,
                            ),
                            Text(
                              "Monday - friday",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "8:30am - 7:00pm",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Saturdays and Public Holidays",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "10:00am - 4:00pm",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ))
                      ],
                    )))
          ],
        ),
      )),
    );
  }

  Future<bool> customerCare() async {
    try {
      var response = await dio.get(
        "/misc/customer-care/phone/",
      );

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');
        var user = await CustomerPhone.fromJson(data);
        setState(() {
          customerCareNumber = user.data.phone;

          debugPrint("name ${customerCareNumber}");
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors!, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> customerServiceEmail() async {
    var response = await dio.get(
      "/misc/customer-care/email/",
    );

    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');
        var user = await CustomerEmail.fromJson(data);
        setState(() {
          customerCareEmail = user.data.email;

          debugPrint("name ${customerCareEmail}");
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors!, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> aboutUser() async {
    final storage = new FlutterSecureStorage();
    DioCacheManager dioCacheManager;
    dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 7),
        forceRefresh: true,
        options: Options(headers: {
          'Authorization': 'Bearer ${await storage.read(key: authToken) ?? ""}'
        }));
    Dio _dio = Dio();
    _dio.interceptors.add(dioCacheManager.interceptor);
    var response = await _dio.get(
      base_url + "/user/profile/",
      options: _cacheOptions,
    );
    debugPrint('Data Code ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');
        var user = await AboutUser.fromJson(data);
        setState(() {
          username = user.data.username;

          debugPrint("name ${username}");
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        return false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
