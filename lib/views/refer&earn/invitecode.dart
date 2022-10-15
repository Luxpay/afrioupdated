import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luxpay/utils/colors.dart';

import '../../models/aboutUser.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';

class InvitationCode extends StatefulWidget {
  const InvitationCode({Key? key}) : super(key: key);

  @override
  State<InvitationCode> createState() => _InvitationCodeState();
}

class _InvitationCodeState extends State<InvitationCode> {
  var username;
  Future<void> share(share) async {
    await FlutterShare.share(
        title: 'Share Luxpay',
        text: share,
        // linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Luxpay Referral Code');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      aboutUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                      "Invitation Code",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 100, left: 30, right: 30),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: grey1,
                        child: Center(
                          child: Text(
                            username ?? "Loading...",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 50, right: 50, top: 30),
                        child: Row(
                          children: [
                            Expanded(
                                child: button(
                                    title: "Copy",
                                    hexColor: "#333333",
                                    onTap: () {
                                      debugPrint("copied");
                                      Fluttertoast.showToast(
                                        msg: username,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity
                                            .BOTTOM, // also possible "TOP" and "CENTER"
                                        backgroundColor: HexColor("#415CA0"),
                                      );
                                      Clipboard.setData(
                                          ClipboardData(text: username));
                                      debugPrint("copied");
                                    })),
                            SizedBox(
                              width: 50,
                            ),
                            Expanded(
                                child: button(
                                    title: "Share",
                                    hexColor: "#144DDE",
                                    onTap: () {
                                      share(username);
                                    }))
                          ],
                        ),
                      )
                    ],
                  )))
        ],
      )),
    );
  }

  Widget button(
      {required String title,
      required String hexColor,
      VoidCallback? onTap,
      bool active = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: SizeConfig.blockSizeHorizontal! * 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: active ? HexColor(hexColor) : HexColor("#E2E2E2"),
          boxShadow: [
            BoxShadow(
              color: grey3.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
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
      base_url + "/v1/user/profile/",
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
