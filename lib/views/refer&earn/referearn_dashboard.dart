import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/errors/authError.dart';
import '../../models/errors/referEarn_ds.dart';
import '../../models/trans_history.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/transfer_card.dart';
import '../finances/transactionPage_details.dart';

class ReferrerEarningDashoard extends StatefulWidget {
  const ReferrerEarningDashoard({Key? key}) : super(key: key);

  @override
  State<ReferrerEarningDashoard> createState() =>
      _ReferrerEarningDashoardState();
}

class _ReferrerEarningDashoardState extends State<ReferrerEarningDashoard> {
  var errors;

  String? totalEarnings, weeklyEarning, weeklyReferrals, crowd365Referrals;
  List<Result> transferList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getDashBoard();
      getTransactionHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Referral Earnings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => {Navigator.maybePop(context)},
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                color: grey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    earningStatus(
                        "EARNINGS THIS WEEK", "NGN ${weeklyEarning ?? 0}"),
                    earningStatus(
                        "TOTAL EARNINGS", "NGN ${totalEarnings ?? 0}"),
                    earningStatus("SIGNUPS", "0"),
                    earningStatus("Signups that subscribe", "0"),
                    earningStatus(
                        "WEEKLY REFERRALS", "${weeklyReferrals ?? 0}"),
                    earningStatus(
                        "No Of Referrals", "${crowd365Referrals ?? 0}"),
                    earningStatus("Next Payout Date", "Every Friday"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Payout history",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  height: 200,
                  width: double.infinity,
                  child: transferList.isEmpty
                      ? Container(
                          child: Stack(children: [
                            Center(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Image.asset('assets/coolicon.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Nothing to see here",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "You haven’t made any transactions yet, all transactions will show up here",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))
                          ]),
                        )
                      : ListView.separated(
                          itemCount:
                              transferList.length < 3 ? transferList.length : 3,
                          itemBuilder: (context, index) {
                            var transfers = transferList[index];
                            var arr = transfers.amount.split('.');
                            var amount = arr[0];
                            var ref = transfers.reference;
                            var dateValue =
                                new DateFormat("yyyy-MM-dd HH:mm:ss")
                                    .parse("${transfers.createdAt}", true)
                                    .toLocal();
                            String formattedDate =
                                DateFormat("MMMd h:mma").format(dateValue);
                            debugPrint("formattedDate = " + formattedDate);
                            return TransferHistoryCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionDetailsPage(
                                                reference: ref,
                                              )));
                                },
                                amount: amount,
                                status: transfers.status,
                                date: formattedDate,
                                type: transfers.type);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(color: Colors.black45);
                          },
                        )),
            ],
          ),
        ),
      ),
    );
  }

  Widget earningStatus(status, value) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 7),
          Text(value)
        ],
      ),
    );
  }

  Future<bool> getDashBoard() async {
    try {
      var response = await dio.get(
        "/v1/refer-earn/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var referEarnData = await ReferEarnDs.fromJson(data);
        setState(() {
          totalEarnings = referEarnData.data.totalEarnings;
          weeklyEarning = referEarnData.data.weeklyEarnings;
          weeklyReferrals = "${referEarnData.data.weeklyReferrals}";
          crowd365Referrals = "${referEarnData.data.crowd365Referrals}";
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
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
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> getTransactionHistory() async {
    try {
      var response = await dio.get(
        "/v1/refer-earn/history/?limit&offset&start&stop",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var transactionData = await TransactionHistory.fromJson(data);
        setState(() {
          transferList = transactionData.data.results;
        });
        debugPrint("OutPut ${transactionData.data.results.length}");
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
        showErrorDialog(context, errors, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
