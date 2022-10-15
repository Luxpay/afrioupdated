import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/transfer_beneficiary.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../widgets/methods/showDialog.dart';

class SelectBeneficiary extends StatefulWidget {
  const SelectBeneficiary({Key? key}) : super(key: key);

  @override
  State<SelectBeneficiary> createState() => _SelectBeneficiaryState();
}

class _SelectBeneficiaryState extends State<SelectBeneficiary> {
  String query = '';
  List<Datum> beneficiaryList = [];
  bool fetchBank = false;
  var errors;

  @override
  void initState() {
    super.initState();
    getTransferBeneficiary();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: beneficiaryList.length.toDouble() + 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
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
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("Select Beneficiary",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              // Container(
                              //     child: IconButton(
                              //   icon: Icon(Icons.cancel),
                              //   onPressed: () => Navigator.pop(context),
                              // )),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60, right: 40, left: 40),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: <Widget>[
                            //buildSearch(),
                            // LuxTextField(
                            //   hint: "Select a LuxPay Tag",
                            //   //controller: controllerRefere,
                            //   innerHint: "Search for LuxTag",
                            //   onChanged: (v) async {
                            //     searchLuxpayTag(v);
                            //     if (v.isEmpty) {
                            //       setState(() {
                            //         getTransferBeneficiary();
                            //       });
                            //     }
                            //   },
                            // ),
                            SingleChildScrollView(
                              child: Container(
                                height:
                                   beneficiaryList.length.toDouble() + 300,
                                child: beneficiaryList.isEmpty
                                    ? Center(
                                        child: Text("No beneficiary found"))
                                    : ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                Divider(height: 1),
                                        itemCount: beneficiaryList.length,
                                        itemBuilder: (context, index) {
                                          final tag = beneficiaryList[index];
                                          return ListTile(
                                            leading: tag.avatar == null
                                                ? Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      color: grey4,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 30,
                                                          color: white,
                                                        )),
                                                  )
                                                : CircleAvatar(
                                                    radius: 30.0,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            '${tag.avatar}'),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                            title: Text(tag.fullName),
                                            subtitle: Text(tag.username),
                                            onTap: () async {
                                              Map<String, dynamic> body = {
                                                "full_name": tag.fullName,
                                                "username": tag.username,
                                                'avatar': tag.avatar
                                              };
                                              Navigator.pop(context, body);
                                              //Navigator.pop(context);
                                            },
                                          );
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

  void searchLuxpayTag(String query) {
    final banks = beneficiaryList.where((data) {
      final titleLower = data.fullName.toLowerCase();
      //print(query);
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.beneficiaryList = banks;
    });
  }

  Future<bool> getTransferBeneficiary() async {
    try {
      var response = await dio.get(
        "/v1/wallets/transfer/beneficiaries/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var bankData = await TransferBeneficiary.fromJson(data);
        setState(() {
          beneficiaryList = bankData.data;
          fetchBank = true;
        });
        debugPrint("OutPut ${bankData.data.length}");
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
        // showChoiceDialog(context, errors, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
