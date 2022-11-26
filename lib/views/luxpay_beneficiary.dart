import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/touchUp.dart';
import '../models/luxpay_beneficiary.dart';

class LuxpayBeneficiary extends StatefulWidget {
  LuxpayBeneficiary({Key? key}) : super(key: key);

  @override
  State<LuxpayBeneficiary> createState() => _LuxpayBeneficiaryState();
}

class _LuxpayBeneficiaryState extends State<LuxpayBeneficiary> {
  List<Result> beneList = [];
  var errors;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLuxpayBeneficiary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 500,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: beneList.isEmpty
            ? Center(child: Text("please wait..."))
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                height: 6,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: grey4,
                                ),
                                margin: const EdgeInsets.only(top: 10)),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, top: 20),
                                  child: CircleButton(
                                      onTap: () => Navigator.pop(context),
                                      iconData: Icons.close))),
                          Container(
                            margin:
                                EdgeInsets.only(top: 60, right: 40, left: 40),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: <Widget>[
                                  SingleChildScrollView(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              290,
                                      child: ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                Divider(height: 3),
                                        itemCount: beneList.length,
                                        itemBuilder: (context, index) {
                                          var bene = beneList[index];
                                          return ListTile(
                                              title: Text("${bene.username}"),
                                              onTap: () async {
                                                Map<String, dynamic> body = {
                                                  "username": bene.username
                                                };
                                                Navigator.pop(context, body);
                                                //Navigator.pop(context);
                                              });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<bool> getLuxpayBeneficiary() async {
    try {
      var response = await dio.get(
        "/wallet/transfer/beneficiaries/?limit&offset",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var bankData = await LuxpayBene.fromJson(data);
        setState(() {
          beneList = bankData.data.results;
        });
        debugPrint("OutPut ${bankData.data.results.length}");
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
          // var errorData = e.response?.data;
          //var errorMessage = await ReferralError.fromJson(errorData);
          // errors = errorMessage.errors.extra.error[0];
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
