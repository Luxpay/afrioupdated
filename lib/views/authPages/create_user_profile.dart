import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxpay/networking/DioServices/dio_errors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/addBvn_page.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../utils/validators.dart';
import '../../widgets/util.dart';

class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({Key? key}) : super(key: key);

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  String selected_gender = 'Male';
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();

  bool _isLoading = false;
  var errors;
  bool imagePicked = false;
  DateTime dateTime = DateTime.now();
  String dateFormate = '';
  String? dateOfBirth, nothing;

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      controllerFirstName.clear();
      controllerLastName.clear();
      return true; // return true if the route to be popped
    }

    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Container(
                child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
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
                        // IconButton(
                        //     onPressed: () => {Navigator.maybePop(context)},
                        //     icon: const Icon(Icons.arrow_back_ios_new)),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 5,
                        ),
                        const Text(
                          "Create your Account",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: EdgeInsets.only(top: 70, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("STEP 1 OF 3",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w100)),
                          SizedBox(height: 20),
                          Text(
                            "Provide Personal Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(
                                        "We will require a few details about you to set up your Luxpay account")),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 180, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 13),
                        LuxTextField(
                          hint: "First Name",
                          controller: controllerFirstName,
                          innerHint: "eg john",
                          boaderColor: HexColor("#D70A0A"),
                        ),
                        SizedBox(height: 10),
                        LuxTextField(
                          hint: "Last Name",
                          controller: controllerLastName,
                          innerHint: "eg blak",
                          boaderColor: HexColor("#D70A0A"),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Gender",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor("#1E1E1E")),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 8),
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text("Select Gender: "),
                                    ),
                                    DropdownButton<String>(
                                      value: selected_gender,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: HexColor("#1E1E1E"),
                                          fontWeight: FontWeight.w300),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selected_gender = newValue!;
                                          print(selected_gender);
                                        });
                                      },
                                      items: <String>['Male', 'Female']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  "Date Of Birth",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#1E1E1E")),
                                )),
                                SizedBox(height: 8),
                                Container(
                                    height: 55,
                                    color:
                                        HexColor("#E8E8E8").withOpacity(0.35),
                                    child: InkWell(
                                        onTap: () {
                                          Utils.showSheet(
                                            context,
                                            child: buildDatePicker(),
                                            onClicked: () {
                                              final value =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(dateTime);
                                              // Utils.showSnackBar(
                                              //     context, 'Selected "$value"');
                                              setState(() {
                                                dateOfBirth = value.toString();
                                                debugPrint(
                                                    "Date Of Birth : $dateOfBirth");
                                              });

                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                "Pick Date of Birth",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(dateOfBirth ?? "",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            )
                                          ],
                                        ))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        InkWell(
                            onTap: () async {
                              var first_name = controllerFirstName.text.trim();
                              var last_name = controllerLastName.text.trim();
                              var gender = selected_gender;
                              String birthDate = dateOfBirth.toString();

                              setState(() {
                                _isLoading = true;
                              });
                              var validators = [
                                Validators.forBank(first_name),
                                Validators.forBank(last_name),
                                //Validators.forBank(gender),
                                gender.isEmpty ? "select gender" : null,
                                birthDate == nothing
                                    ? "Pick a BirthDate"
                                    : null,
                              ];
                              if (validators
                                  .any((element) => element != null)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(validators.firstWhere(
                                                (element) => element != null) ??
                                            "")));
                                return;
                              }

                              var response = await createUserData(
                                  firstName: first_name,
                                  lastName: last_name,
                                  gender: gender,
                                  dateOfBirth: birthDate);

                              if (!response) {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errors)));
                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddBvnPage()));
                              }
                            },
                            child: _isLoading
                                ? luxButtonLoading(HexColor("#D70A0A"), width)
                                : luxButton(HexColor("#D70A0A"), Colors.white,
                                    "Continue", width,
                                    fontSize: 16))
                      ],
                    ),
                  ),
                ),
              ],
            )),
          )),
        ));
  }

  Widget buildDatePicker() => SizedBox(
        height: 600,
        child: CupertinoDatePicker(
          minimumYear: 1950,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Future<bool> createUserData({
    required String? firstName,
    required String? lastName,
    required String? dateOfBirth,
    required String? gender,
  }) async {
    Map<String, dynamic> body = {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
    };

    try {
      var response = await dio.put(
        "/user/profile/",
        data: body,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        var errorData = e.response?.data;
        var errorMessage = await AuthError.fromJson(errorData);
        errors = errorMessage.message;
        return false;
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
