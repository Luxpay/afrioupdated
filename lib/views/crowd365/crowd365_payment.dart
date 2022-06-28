import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/utils/sizeConfig.dart';

import '../../models/walletsModel.dart';
import '../../networking/dio.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';
import '../../models/errors/refferal.dart';
import '../../widgets/methods/showDialog.dart';
import 'crowd365_dashboard.dart';

class Crowd365PaymentMethod extends StatefulWidget {
  String? packageName, packagePrice;
  Crowd365PaymentMethod(
      {Key? key, required this.packageName, required this.packagePrice})
      : super(key: key);

  @override
  State<Crowd365PaymentMethod> createState() => _Crowd365PaymentMethodState();
}

class _Crowd365PaymentMethodState extends State<Crowd365PaymentMethod> {
  bool selectPackageCheck = false;
  int selectedIndex = -1;
  List? walletInfo;
  bool checkdata = false;
  DioCacheManager? _dioCacheManager;
  bool _isLoading = false;
  var errors;
  String? price;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWallets();
    setState(() {
      price = widget.packagePrice;
      name = widget.packageName;
      print(price);
      print(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: walletInfo == null
          ? Center(
              child: CircularProgressIndicator(
                color: HexColor("#415CA0"),
              ),
            )
          : Stack(
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 16, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    icon: const Icon(Icons.arrow_back_ios_new),
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width:
                                        SizeConfig.safeBlockHorizontal! * 2.4,
                                  ),
                                  const Text(
                                    "Payment Method",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              "Select payment",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            )),
                        Container(
                          height: 400,
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                //var item = items[index];
                                return GestureDetector(
                                    onTap: () => setState(() {
                                          selectedIndex = index;
                                          selectPackageCheck = true;
                                        }),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, top: 20, right: 20),
                                      child: Container(
                                        height: 100,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                child: Image.asset(
                                                  "assets/fund-tag.png",
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 30, left: 100),
                                                child: Column(
                                                  children: [
                                                    Text("Wallet Balance",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "${walletInfo![index].balanceCurrency} ${walletInfo![index].balance}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 30),
                                                  child: selectedIndex == index
                                                      ? Image.asset(
                                                          'assets/selected_radio.png',
                                                        )
                                                      : Image.asset(
                                                          'assets/unselect_radio.png',
                                                          color: Colors.grey)
                                                          ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: SizeConfig.blockSizeVertical! * 2,
                                  ),
                              itemCount: walletInfo!.length),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 40, left: 20, right: 20, bottom: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                var validators = [
                                  selectPackageCheck == false
                                      ? "Please Select a Payment Method"
                                      : null,
                                  name == null
                                      ? "No Pakage Name Found try again"
                                      : null
                                ];
                                if (validators
                                    .any((element) => element != null)) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showChoiceDialog(
                                      context,
                                      validators.firstWhere(
                                              (element) => element != null) ??
                                          "","Crowd365");
                                  return;
                                }
                                var res = await packageSelected(
                                  name,
                                  walletInfo![selectedIndex].balanceCurrency,
                                );
                                // create a scaffold messenger that displays res as text
                                print('check: $res');
                                if (!res) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showChoiceDialog(context, errors,"Crowd365");
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Crowd365Dashboard()));
                                }
                              },
                              child: _isLoading
                                  ? luxButtonLoading(
                                      HexColor("#415CA0"), double.infinity)
                                  : luxButton(HexColor("#415CA0"), Colors.white,
                                      "Pay", double.infinity,
                                      fontSize: 16, height: 50, radius: 8)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            child: Image.asset(
                          "assets/fprint_blue.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ));
  }

  Future<bool> packageSelected(String? name, String? currency) async {
    final storage = new FlutterSecureStorage();
    String? referrerCode = await storage.read(key: "Crowd365ReferalCode");
    print(name);
    //YTIQLW
    Map<String, dynamic> body = {
      "referrer": referrerCode,
      "package": name,
      "currency": currency
    };
    if (referrerCode == null) {
      body.remove('referrer');
    }
    debugPrint("Package Selected : $body");
    try {
      var response = await dio.post(
        "/api/v1/crowd365/subscribe/",
        data: body,
      );
      //GCLV9M
      debugPrint("${response.statusCode}");
      if (response.statusCode == 201) {
        var data = response.data;
        debugPrint("Crow365 Data : ${data}");
        await storage.delete(key: 'Crowd365ReferalCode');
        print('Referrer code delete');
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          showChoiceDialog(context, errors,"Crowd365");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await ReferralError.fromJson(errorData);
          errors = errorMessage.errors.extra.error[0];
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> getWallets() async {
    try {
      final storage = new FlutterSecureStorage();

      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 7),
          forceRefresh: true,
          options: Options(headers: {
            'Authorization':
                'Bearer ${await storage.read(key: authToken) ?? ""}'
          }));
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager!.interceptor);
      var response = await _dio.get(
        base_url + "/api/v1/finance/",
        options: _cacheOptions,
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await MyWallets.fromJson(data);
        setState(() {
          checkdata = true;
          walletInfo = walletData.data;
        });
        debugPrint('Wallet Data : ${walletData.data.length}');

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          showChoiceDialog(context, errors,"Crowd365");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await ErrorMessages.fromJson(errorData);
          errors = errorMessage.errors.message;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

}
