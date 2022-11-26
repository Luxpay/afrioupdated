import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/errors/authError.dart';
import '../../models/kyc_detail.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';

class UpgradeKYCDetails extends StatefulWidget {
  final String id;
  UpgradeKYCDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<UpgradeKYCDetails> createState() => _UpgradeKYCDetailsState();
}

class _UpgradeKYCDetailsState extends State<UpgradeKYCDetails> {
  String? firstName,
      lastname,
      middlename,
      gender,
      dateOfBirth,
      idType,
      idNumber;

  var errors;
  var errorss;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userDetailsKYC(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  // margin: EdgeInsets.only(top: 20),
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
                        "KYC Details",
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
                    margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                    child: Container(
                      child: firstName == null
                          ? Container(
                              margin: EdgeInsets.only(top: 300),
                              child: Center(child: CircularProgressIndicator()))
                          : Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "First Name",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${firstName ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal! * 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Middle Name",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${middlename ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal! * 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last Name",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${lastname ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal! * 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gender",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${gender ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal! * 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date Of Birth",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${dateOfBirth ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal! * 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID Type",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${idType ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal! * 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID Number",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.safeBlockHorizontal! * 1.5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: grey2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "${idNumber ?? "N/A"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      SizeConfig.safeBlockHorizontal! * 10.5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: button(
                                            title: "APPROVE",
                                            hexColor: "#00ab41",
                                            onTap: () {
                                              loadVerifyDetails(context,
                                                  docID: "${widget.id}",
                                                  status: "APPROVED");
                                            })),
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal! * 10,
                                    ),
                                    Expanded(
                                        child: button(
                                            title: "REJECT",
                                            hexColor: "#D70A0A",
                                            onTap: () {
                                              loadVerifyDetails(context,
                                                  docID: "${widget.id}",
                                                  status: "REJECTED");
                                            }))
                                  ],
                                ),
                              ],
                            ),
                    )))
          ],
        ),
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
        height: 50,
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
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<bool> userDetailsKYC(proccessID) async {
    try {
      var response = await dio.get("/user/upgrade/manage/$proccessID/");
      debugPrint('Data Code ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');
        var user = await KycDetails.fromJson(data);
        setState(() {
          firstName = user.data.user.firstName;
          lastname = user.data.user.lastName;
          gender = user.data.user.gender;
          dateOfBirth = "${user.data.user.dateOfBirth}";
          middlename = user.data.user.middleName;
          idType = user.data.idType;
          idNumber = user.data.idNumber;

          // debugPrint("name ${username}");
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          Navigator.of(context).pop();
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          //handleStatusCode(e.response?.statusCode, context);
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        Navigator.of(context).pop();
        errors = errorMessage;
        showErrorDialog(context, errors, "Luxpay");

        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> verifyKYCDetails(String docId, String status) async {
    try {
      Map<String, dynamic> body = {"status": status};
      var response = await dio.put(
        "/user/upgrade/manage/$docId/",
        data: body,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var userData = await AuthError.fromJson(data);
        errorss = userData.message;
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
          errorss = errorMessage.message;
          return false;
        }
      } else {
        errorss = errorMessage;
        showErrorDialog(context, errors, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void loadVerifyDetails(BuildContext context, {docID, status}) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    Future.delayed(const Duration(milliseconds: 100), () async {
// Here you can write your code

      var response = await verifyKYCDetails(docID, status);
      if (response) {
        Navigator.of(context).pop();
        showErrorDialog(context, errorss, "KYC Verify");
      } else {
        Navigator.of(context).pop();
        showErrorDialog(context, errorss, "KYC Verify");
      }
    });
  }
}
