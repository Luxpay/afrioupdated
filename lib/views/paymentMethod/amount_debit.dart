import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/errors/authError.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/paymentMethod/webview_debitCard.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import '../../models/debitcard_url.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/validators.dart';
import '../../widgets/methods/showDialog.dart';

class DebitAmount extends StatefulWidget {
  final String channel;
  const DebitAmount({Key? key, required this.channel}) : super(key: key);

  @override
  _DebitAmountState createState() => _DebitAmountState();
}

class _DebitAmountState extends State<DebitAmount> {
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();

  //String? fullname, encryption_key, public_key, amountp, email, tx_ref, phone;

  String? errors, channel;

  String? urlLink;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 2.4,
                ),
                const Text(
                  "Fund account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 1.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  LuxTextField(
                      hint: "Amount (N)",
                      controller: controller,
                      innerHint: 'amount',
                      textInputType: TextInputType.number),
                  SizedBox(height: 20),
                  Center(
                      child: InkWell(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            var amount = controller.text.trim();

                            var ego = int.parse(amount);
                            var validators = [
                              Validators.isValidAmount(amount),
                              ego <= 999
                                  ? "Ensure this amount is greater than or equal to 1000."
                                  : null
                            ];
                            if (validators.any((element) => element != null)) {
                              setState(() {
                                _isLoading = false;
                              });
                              showErrorDialog(
                                  context,
                                  validators.firstWhere(
                                          (element) => element != null) ??
                                      "",
                                  "Fund Luxpay Account");
                              return;
                            }

                            var response = await debitAmount(amount);

                            debugPrint("payment: $response");
                            if (response) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WebViewDebitCardTransfer(debitUrl:urlLink)));

                              // beginPayment(
                              //     encryption_key: encryption_key,
                              //     public_key: public_key,
                              //     email: email,
                              //     tx_ref: tx_ref,
                              //     phone: phone,
                              //     context: context,
                              //     fullname: fullname,
                              //     amount: amountp);
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              showErrorDialog(
                                  context, errors!, "Fund Luxpay Account");
                            }
                          },
                          child: _isLoading
                              ? luxButtonLoading(HexColor("#D70A0A"), width)
                              : luxButton(HexColor("#D70A0A"), Colors.white,
                                  "Send", width,
                                  fontSize: 16))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> debitAmount(amount) async {
    Map<String, dynamic> body = {"amount": amount, 'channel': channel};
    try {
      var response = await dio.post("/finances/deposit/", data: body);
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var debitData = await Deposit.fromJson(data);
        setState(() {
          urlLink = debitData.data.link;
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
        showErrorDialog(context, errors!, "Banks");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
