import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxpay/views/accounts_subviews/upgrade_kyc_details.dart';
import '../../models/kyc_history.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/transfer_card.dart';

class UpgradeKYCListPage extends StatefulWidget {
  UpgradeKYCListPage({Key? key}) : super(key: key);

  @override
  State<UpgradeKYCListPage> createState() => _UpgradeKYCListPageState();
}

class _UpgradeKYCListPageState extends State<UpgradeKYCListPage> {
  var errors;
  List<Result> kycList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getKYCHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KYC"),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
      ),
      body: kycList.isEmpty
          ? Center(
              child: Text("No pending KYC request"),
            )
          : Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ListView.separated(
                itemCount: kycList.length,
                itemBuilder: (context, index) {
                  var kyc = kycList[index];
                  var ref = kyc.id;
                  var dateValue = new DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse("${kyc.createdAt}", true)
                      .toLocal();
                  String formattedDate =
                      DateFormat("MMMd h:mma").format(dateValue);

                  return KYCCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpgradeKYCDetails(
                                    id: ref,
                                  )));
                    },
                    phone: kyc.phone,
                    status: kyc.status,
                    date: formattedDate,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.black45);
                },
              ),
            ),
    );
  }

  Future<bool> getKYCHistory() async {
    try {
      var response = await dio.get(
        "/user/upgrade/manage/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var kycData = await KycHistory.fromJson(data);
        setState(() {
          kycList = kycData.data.results;
        });
        debugPrint("OutPut ${kycData.data.results.length}");
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
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Luxpay KYC");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
