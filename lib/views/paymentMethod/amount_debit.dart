import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/errors/authError.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/payment_page.dart';
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

  String? fullname, encryption_key, public_key, amountp, email, tx_ref, phone;

  String? errors, channel;

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
                            var amount = controller.text.trim();
                            var validators;
                            validators = [
                              Validators.isValidAmount(amount),
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

                            var response = await debitAmount(amount);

                            debugPrint("SignUp: $response");
                            if (response) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentWidget(
                                          encryption_key: encryption_key,
                                          public_key: public_key,
                                          email: email,
                                          tx_ref: tx_ref,
                                          phone: phone,
                                          channel: channel,
                                          fullname: fullname,
                                          amount: amountp)));
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          errors ?? "something went wrong")));
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
      var response = await dio.post("/v1/finances/deposit/", data: body);
      debugPrint('${response.statusCode}');
      if (response.statusCode == 201) {
        var data = response.data;
        var debitData = await Deposit.fromJson(data);
        setState(() {
          encryption_key = debitData.data.encryptionKey;
          public_key = debitData.data.publicKey;
          email = debitData.data.email;
          tx_ref = debitData.data.txRef;
          phone = debitData.data.phone;
          fullname = debitData.data.fullName;
          amountp = debitData.data.amount;
          channel = debitData.data.metaData.channel;
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
