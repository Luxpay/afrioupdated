import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../utils/validators.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';
import 'add_address.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  String state = "";
  String city = "";
  String discrit = "";
  var controllerContact = TextEditingController();
  var controllerFirstName = TextEditingController();
  var controllerLastName = TextEditingController();
  var controllerAppartment = TextEditingController();
  bool _isLoading = false;

  String? errors;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double heightt = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
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
                      "My Address",
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
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Container(
                    height: heightt,
                    child: Column(
                      children: [
                        LuxTextField(
                          hint: "Contact Information",
                          controller: controllerContact,
                          innerHint: "phone",
                        ),
                        SizedBox(height: 10),
                        LuxTextField(
                          hint: "My Address",
                          controller: controllerFirstName,
                          innerHint: "FirstName",
                        ),
                        SizedBox(height: 10),
                        LuxTextField(
                          hint: "",
                          controller: controllerLastName,
                          innerHint: "lastName",
                        ),
                        SizedBox(height: 10),
                        LuxTextField(
                          hint: "",
                          controller: controllerAppartment,
                          innerHint: "Appartment, suit, etc",
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 54,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "State",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#333333")
                                            .withOpacity(0.25),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: state,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#1E1E1E"),
                                      fontWeight: FontWeight.w300),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      state = newValue!;
                                      print(state);
                                    });
                                  },
                                  items: <String>[
                                    'Enugu',
                                    'Lagos',
                                    'Abuja',
                                    'Kaduna',
                                    'Kanu',
                                    ""
                                  ].map<DropdownMenuItem<String>>(
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
                        SizedBox(height: 20),
                        Container(
                          height: 54,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "City",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#333333")
                                            .withOpacity(0.25),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: city,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#1E1E1E"),
                                      fontWeight: FontWeight.w300),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      city = newValue!;
                                      print(city);
                                    });
                                  },
                                  items: <String>[
                                    'Lekki',
                                    'Otigba',
                                    'Alilia',
                                    ""
                                  ].map<DropdownMenuItem<String>>(
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
                        SizedBox(height: 20),
                        Container(
                          height: 54,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              color: HexColor("#E8E8E8").withOpacity(0.35),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "District ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#333333")
                                            .withOpacity(0.25),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: discrit,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor("#1E1E1E"),
                                      fontWeight: FontWeight.w300),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      discrit = newValue!;
                                      print(discrit);
                                    });
                                  },
                                  items: <String>[
                                    'Winners',
                                    "",
                                  ].map<DropdownMenuItem<String>>(
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
                        LuxTextField(
                          hint: "",
                          // controller: controller,
                          innerHint: "Email(optional)",
                        ),
                        SizedBox(height: 50),
                        InkWell(
                          onTap: () async {
                            var address = controllerContact.text.trim();
                            var city = controllerFirstName.text.trim();
                            var state = controllerLastName.text.trim();
                            var zipCode = controllerAppartment.text.trim();

                            var validators = [
                              Validators.forEmptyField(address),
                              Validators.forEmptyField(state),
                              Validators.forEmptyField(city),
                              Validators.forEmptyField(zipCode),
                            ];
                            if (validators.any((element) => element != null)) {
                              setState(() {
                                _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(validators.firstWhere(
                                              (element) => element != null) ??
                                          "")));
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });

                            var response =
                                await addAddress(address, city, state, zipCode);
                            setState(() {
                              _isLoading = false;
                            });
                            debugPrint("Add Address: $response");
                            if (response) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNewAddress()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          errors ?? "something went wrong")));
                            }
                          },
                          child: Container(
                            child: _isLoading
                                ? luxButtonLoading(HexColor("#D70A0A"), width)
                                : luxButton(HexColor("#D70A0A"), Colors.white,
                                    "save address", width,
                                    fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          )
        ],
      )),
    );
  }

  Future<bool> addAddress(
      String address, String city, String state, String zipcode) async {
    Map<String, dynamic> body = {
      "address": address,
      "city": city,
      "state": state,
      "zip_code": zipcode,
      "default": true
    };
    try {
      var response = await dio.post(
        "/v1/user/addresses/",
        data: body,
      );

      if (response.statusCode == 201) {
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
