import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/kycModel.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/views/accountSettings/account_profile.dart';

import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';

class KYCPage extends StatefulWidget {
  const KYCPage({Key? key}) : super(key: key);

  @override
  State<KYCPage> createState() => _KYCPageState();
}

class _KYCPageState extends State<KYCPage> {
  var errors;
  List<Datum> kycList = [];
  List<String> leves = ["1", "2", "3"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aboutKyc();
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
              height: 60,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    const Text(
                      "KYC Levels",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: kycList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: EdgeInsets.only(top: 70),
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "KYC regulations are set by the Central Bank of Nigeria. KYC simply stands for “Know Your Customer”. The requirements are developed to prevent identity theft, financial fraud, money laundering and terrorist financing.",
                                  style: TextStyle(color: grey10, fontSize: 15),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical! *
                                                    2,
                                          ),
                                      itemCount: kycList.length,
                                      itemBuilder: (context, index) {
                                        var data = kycList[index];

                                        var kycL = leves[index];
                                        return Container(
                                          child: kyc_card(
                                            levels: kycL,
                                            singleTransactionLimit:
                                                data.single.debit,
                                            dailyLimit: data.dailyLimit,
                                            cummuLimit: data.cummulativeLimit ??
                                                "unlimited",
                                            maxLimit: data.single.credit ??
                                                'unlimited',
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )),
                    ),
                  ),
          )
        ],
      )),
    );
  }

  Future<bool> aboutKyc() async {
    try {
      var response = await dio.get(
        "/wallet/levels/",
      );
      debugPrint('Data Code ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');

        var kycLevel = await AllKycLevels.fromJson(data);

        setState(() {
          kycList = kycLevel.data;
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
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
