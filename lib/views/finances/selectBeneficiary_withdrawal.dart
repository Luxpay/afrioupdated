import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../models/errors/authError.dart';
import '../../models/withdralbeneficiary.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../widgets/methods/showDialog.dart';

class SelectBeneficiaryWithdrawal extends StatefulWidget {
  const SelectBeneficiaryWithdrawal({Key? key}) : super(key: key);

  @override
  State<SelectBeneficiaryWithdrawal> createState() =>
      _SelectBeneficiaryWithdrawalState();
}

class _SelectBeneficiaryWithdrawalState
    extends State<SelectBeneficiaryWithdrawal> {
  String query = '';
  List<Results> beneficiaryList = [];
  bool fetchwithdrawalbene = false;
  var errors;

  @override
  void initState() {
    super.initState();
    getWithdrawalBeneficiary();
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
                            //   hint: "Select a Beneficiary",
                            //   //controller: controllerRefere,
                            //   innerHint: "Search for Beneficiary",
                            //   onChanged: (v) async {
                            //     searchAccount(v);
                            //     if (v.isEmpty) {
                            //       setState(() {
                            //         searchAccount(v);
                            //       });
                            //     }
                            //   },
                            // ),
                            SingleChildScrollView(
                              child: Container(
                                height: beneficiaryList.length.toDouble() + 300,
                                child: beneficiaryList.isEmpty
                                    ? Center(child: Text("No Beneficiary Save"))
                                    : ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                Divider(height: 1),
                                        itemCount: beneficiaryList.length,
                                        itemBuilder: (context, index) {
                                          final tag = beneficiaryList[index];
                                          return ListTile(
                                            title: Text(tag.accountName),
                                            subtitle: Text(tag.accountNumber),
                                            onTap: () async {
                                              Map<String, dynamic> body = {
                                                "account_name": tag.accountName,
                                                "account_number":
                                                    tag.accountNumber,
                                                "bank_code": tag.bankCode,
                                                "bank_name": tag.bankName
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

  void searchAccount(String query) {
    final account = beneficiaryList.where((data) {
      final titleLower = data.accountName.toLowerCase();
      //print(query);
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.beneficiaryList = account;
    });
  }

  Future<bool> getWithdrawalBeneficiary() async {
    try {
      var response = await dio.get(
        "/v1/finances/withdraw/beneficiaries",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var accountData = await WithdrawalBeneficiary.fromJson(data);
        setState(() {
          beneficiaryList = accountData.data.results;

          fetchwithdrawalbene = true;
        });
        debugPrint("OutPut ${accountData.data.results}");
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
        //showChoiceDialog(context, errors, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
