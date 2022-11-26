import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_user_data.dart';
import 'package:luxpay/views/authPages/dont_know_your_bvn.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/touchUp.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/validators.dart';
import '../../widgets/methods/showDialog.dart';

class AddBvnPage extends StatefulWidget {
  const AddBvnPage({Key? key}) : super(key: key);

  @override
  State<AddBvnPage> createState() => _AddBvnPageState();
}

class _AddBvnPageState extends State<AddBvnPage> {
  bool _isLoading = false;
  var errors;
  DateTime dateTime = DateTime.now();
  String dateFormate = '';
  String? dateOfBirth;
  TextEditingController bvnController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: HexColor("#333333").withOpacity(0.3),
                      width: 0.5,
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {Navigator.maybePop(context)},
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 1,
                      ),
                      const Text(
                        "Create your Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("STEP 2 OF 3"),
                    SizedBox(height: 20),
                    Text(
                      "Link your BVN",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                              child: Text(
                                  "Enter your 11 digits BVN number to unlock various features on the Luxpay account")),
                        ],
                      ),
                    ),
                    SizedBox(height: 13),
                    PasswordTextField(hint: "BVN", controller: bvnController),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                              child: Text(
                                  "* Your BVN is confidential and won’t be disclosed to any third-party")),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                              child: Text("* This is a one time verification")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                margin: EdgeInsets.only(top: 400),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                      onTap: () async {
                        var bvnNumber = bvnController.text.trim();

                        var validators = [
                          Validators.isValidBvn(bvnNumber),
                        ];
                        if (validators.any((element) => element != null)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(validators.firstWhere(
                                      (element) => element != null) ??
                                  "")));
                          return;
                        }

                        setState(() {
                          _isLoading = true;
                        });
                        var response = await upgradeAccount("BVN", bvnNumber);

                        if (!response) {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(errors)));
                          setState(() {
                            _isLoading = false;
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateUserProfileData()));

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: _isLoading
                          ? luxButtonLoading(HexColor("#D70A0A"), 360)
                          : luxButton(HexColor("#D70A0A"), Colors.white,
                              "Submit", 350)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 500),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            _dontKnowUrBVNBottomSheet(context);
                          },
                          child: Text(
                            "Don't know your BVN ?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Not Ready ?',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Skip',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 7, 139, 248),
                                      fontSize: 15),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateUserProfileData()));
                                    })
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<bool> upgradeAccount(String idType, String idNumber) async {
    Map<String, dynamic> body = {"id_type": idType, 'id_number': idNumber};
    try {
      var response = await dio.post(
        "/user/upgrade/",
        data: body,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var userData = await AuthError.fromJson(data);
        errors = userData.message;
        return true;
      } else {
        setState(() {
          _isLoading = false;
        });
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else if (e.response?.statusCode == 400) {
          errors = "This field is required.";
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

void _dontKnowUrBVNBottomSheet(context) {
  showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DontKnowUrBVN();
      });
}
