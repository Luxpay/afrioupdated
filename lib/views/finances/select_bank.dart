import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/get_banks.dart';

import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/touchUp.dart';

class SelectBank extends StatefulWidget {
  SelectBank({Key? key}) : super(key: key);

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  List<Datum> bankList = [];
  String query = '';
  bool fetchBank = false;
  var errors;

  @override
  void initState() {
    super.initState();

    getBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 700,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: fetchBank == false
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 30, left: 30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: <Widget>[
                            LuxTextField(
                              hint: "Select a Bank",
                              //controller: controllerRefere,
                              innerHint: "Search for a Bank",
                              //onChanged: searchBook,
                              onChanged: (v) async {
                                searchBank(v);
                                if (v.isEmpty) {
                                  setState(() {
                                    getBanks();
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(height: 1),
                                itemCount: bankList.length,
                                itemBuilder: (context, index) {
                                  var banks = bankList[index];
                                  return ListTile(
                                      title: Text("${banks.bankName}"),
                                      // subtitle: Text(banks.bankCode),
                                      onTap: () async {
                                        Map<String, dynamic> body = {
                                          "bank_code": banks.bankCode,
                                          "bank_name": banks.bankName
                                        };
                                        Navigator.pop(context, body);
                                        //Navigator.pop(context);
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void searchBank(String query) {
    final banks = bankList.where((data) {
      final titleLower = data.bankName.toLowerCase();
      //print(query);
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.bankList = banks;
    });
  }

  Future<bool> getBanks() async {
    try {
      var response = await dio.get(
        "/finances/withdraw/banks/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var bankData = await GetBanks.fromJson(data);
        setState(() {
          bankList = bankData.data;
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
