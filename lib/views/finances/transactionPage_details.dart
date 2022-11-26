import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/errors/authError.dart';
import '../../models/transaction_details.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../widgets/methods/showDialog.dart';

class TransactionDetailsPage extends StatefulWidget {
  final String reference;
  const TransactionDetailsPage({Key? key, required this.reference})
      : super(key: key);

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  var errors;
  String? from,
      to,
      fee,
      actualAmount,
      channel,
      references,
      type,
      status,
      amount,
      description;
  String? date;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      detailsOfTransaction(widget.reference);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: from == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: HexColor("#D70A0A"),
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.maybePop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_new,
                                        color: Colors.white)),
                                Text(
                                  "Account Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // IconButton(
                                //     onPressed: () =>
                                //         {Navigator.maybePop(context)},
                                //     icon: const Icon(Icons.library_books,
                                //         color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 100),
                        height: 900,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Center(
                                child: Image.asset(
                                  "assets/moreToLife.png",
                                  scale: 1.6,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Transaction Details",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  TransDetails(
                                      to: "${to ?? 'N/A'}",
                                      from: "$from",
                                      fee: '$fee',
                                      amount:
                                          "${amount!.replaceAllMapped(reg, mathFunc)}",
                                      description: "$description",
                                      channel: "$channel",
                                      reference: "$references",
                                      type: "$type",
                                      actual_amount:
                                          "${actualAmount!.replaceAllMapped(reg, mathFunc)}",
                                      status: "$status",
                                      date: '$date')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }

  Future<bool> detailsOfTransaction(String uId) async {
    try {
      var response = await dio.get(
        "/wallet/history/$uId/",
      );

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        var transDetals = await TransactionDetails.fromJson(data);
        var dateValue = new DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse("${transDetals.data.createdAt}", true)
            .toLocal();
        String formattedDate = DateFormat("MMMd h:mma").format(dateValue);
        debugPrint("formattedDate = " + formattedDate);
        setState(() {
          from = transDetals.data.data.from;
          to = transDetals.data.data.to;
          fee = transDetals.data.fee;
          channel = transDetals.data.channel;
          references = transDetals.data.reference;
          type = transDetals.data.type;
          status = transDetals.data.status;
          amount = transDetals.data.amount;
          actualAmount = transDetals.data.actualAmount;
          description = transDetals.data.data.description;
          date = formattedDate;
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
        //showChoiceDialog(context, errors, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

class TransDetails extends StatelessWidget {
  final String? from,
      to,
      fee,
      channel,
      reference,
      type,
      status,
      amount,
      description,
      actual_amount,
      date;
  TransDetails(
      {Key? key,
      this.to,
      this.channel,
      this.fee,
      required this.date,
      this.from,
      this.reference,
      this.actual_amount,
      this.status,
      this.amount,
      this.description,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "From",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$from",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "To",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$to",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Amount",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$amount",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Actual Amount",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$actual_amount",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Description",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$description",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Fee",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "N${fee}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Channel",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$channel",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Reference",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Text(
                      "${reference}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Type",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$type",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Status",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "$status",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Date",
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(child: Text("$date")),
                ],
              ),
            ),
          ],
        ));
  }
}
