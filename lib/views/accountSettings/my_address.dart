import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

import '../../models/errors/authError.dart';
import '../../models/states.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../utils/validators.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  var controllerContact = TextEditingController();
  var controllerFirstName = TextEditingController();
  var controllerLastName = TextEditingController();
  var controllerAppartment = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerZipcode = TextEditingController();

  bool _isLoading = false;
  List<Datum> statesList = [];
  List<Datum> lgaList = [];
  List<Datum> wardList = [];
  String? errors;
  var stateName, lgaName, wardName;
  String? stateID, lgaID, wardID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getStates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double heightt = MediaQuery.of(context).size.height;
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
                          SizedBox(height: 10),
                          LuxTextField(
                            hint: "",
                            controller: controllerZipcode,
                            innerHint: "ZipCode",
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: HexColor("#E8E8E8").withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    DropdownButton<Datum>(
                                      value: stateName,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: HexColor("#1E1E1E"),
                                          fontWeight: FontWeight.w300),
                                      onChanged: (newValue) async {
                                        setState(() {
                                          stateID = newValue!.id.toString();
                                          debugPrint("State ID: $stateID");
                                          stateName = newValue;
                                        });
                                        await lAG(stateID);
                                      },
                                      items: statesList
                                          .map<DropdownMenuItem<Datum>>(
                                              (Datum value) {
                                        return DropdownMenuItem<Datum>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: HexColor("#E8E8E8").withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    DropdownButton<Datum>(
                                      value: lgaName,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: HexColor("#1E1E1E"),
                                          fontWeight: FontWeight.w300),
                                      onChanged: (newValue) async {
                                        setState(() {
                                          lgaID = newValue!.id.toString();
                                          debugPrint("Local Govt ID: $lgaID");
                                          lgaName = newValue;
                                        });
                                        await Ward(stateID, lgaID);
                                      },
                                      items: lgaList
                                          .map<DropdownMenuItem<Datum>>(
                                              (Datum value) {
                                        return DropdownMenuItem<Datum>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: HexColor("#E8E8E8").withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    DropdownButton<Datum>(
                                      value: wardName,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 16,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: HexColor("#1E1E1E"),
                                          fontWeight: FontWeight.w300),
                                      onChanged: (newValue) {
                                        setState(() {
                                          wardID = newValue!.id.toString();
                                          debugPrint("Ward ID: $wardID");
                                          wardName = newValue;
                                        });
                                      },
                                      items: wardList
                                          .map<DropdownMenuItem<Datum>>(
                                              (Datum value) {
                                        return DropdownMenuItem<Datum>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          LuxTextField(
                            hint: "",
                            controller: controllerEmail,
                            innerHint: "Email(optional)",
                          ),
                          SizedBox(height: 50),
                          InkWell(
                            onTap: () async {
                              var phoneContact = controllerContact.text.trim();
                              var firstName = controllerFirstName.text.trim();
                              var lastName = controllerLastName.text.trim();
                              var address = controllerAppartment.text.trim();
                              var email = controllerEmail.text.trim();
                              var zipcode = controllerZipcode.text.trim();

                              var validators = [
                                Validators.forEmptyField(address),
                                Validators.forEmptyField(firstName),
                                Validators.forEmptyField(lastName),
                                Validators.forEmptyField(phoneContact),
                                Validators.forEmptyField(zipcode),
                              ];
                              if (validators
                                  .any((element) => element != null)) {
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

                              var response = await addAddress(
                                  address: address,
                                  phone: phoneContact,
                                  fristname: firstName,
                                  lastname: lastName,
                                  zipcode: zipcode,
                                  state_ID: stateID,
                                  lga_id: lgaID,
                                  ward_id: wardID,
                                  email: email);
                              setState(() {
                                _isLoading = false;
                              });
                              debugPrint("Add Address: $response");
                              if (response) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => AddNewAddress()));
                                showErrorDialog(
                                    context,
                                    "Successfully Added a\n Address",
                                    "Address");
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
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      )),
    );
  }

  Future<bool> addAddress(
      {address,
      state_ID,
      fristname,
      lastname,
      lga_id,
      ward_id,
      email,
      phone,
      zipcode}) async {
    Map<String, dynamic> body = {
      "address": address,
      "state_id": state_ID,
      "lga_id": lga_id,
      "ward_id": ward_id,
      "zip_code": zipcode,
      "is_default": true,
      // "email": email,
      // "phone": phone,
      // "first_name": fristname,
      // "last_name": lastname
    };
    try {
      var response = await dio.post(
        "/addresses/",
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

  Future<bool> getStates() async {
    try {
      var response = await dio.get(
        "/addresses/states/",
      );

      if (response.statusCode == 200) {
        var data = response.data;
        var states = await States.fromJson(data);
        setState(() {
          statesList = states.data;
          stateName = states.data[0];
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

  Future<bool> lAG(id) async {
    try {
      var response = await dio.get(
        "/addresses/states/$id/",
      );

      if (response.statusCode == 200) {
        var data = response.data;
        var states = await States.fromJson(data);
        setState(() {
          lgaList = states.data;
          lgaName = states.data[0];
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

  Future<bool> Ward(sID, iID) async {
    try {
      var response = await dio.get(
        "/addresses/states/$sID/$iID/",
      );

      if (response.statusCode == 200) {
        var data = response.data;
        var states = await States.fromJson(data);
        setState(() {
          wardList = states.data;
          wardName = states.data[0];
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
