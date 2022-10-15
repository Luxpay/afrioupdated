
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class PaymentWidget extends StatefulWidget {
  final String? channel,
      encryption_key,
      public_key,
      amount,
      email,
      tx_ref,
      phone,
      fullname;

  const PaymentWidget(
      {Key? key,
      required this.encryption_key,
      required this.public_key,
      required this.email,
      required this.tx_ref,
      required this.phone,
      required this.channel,
      required this.fullname,
      required this.amount})
      : super(key: key);
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {

  bool constChannel = false;
  final String currency = FlutterwaveCurrency.NGN;
  String? encryptionKey, publicKey, email, phoneNumber, txRef, fullName;
  var errors;

  bool checkChannel(String? channel) {
    if (channel == "BANK") {
      constChannel = true;
      return true;
    } else if (channel == "CARD") {
      constChannel = true;
      return true;
    } else if (channel == 'USSD') {
      constChannel = true;
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
    //  beginPayment();
      checkChannel(widget.channel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  beginPayment() async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
      context: this.context,
      encryptionKey: "${widget.encryption_key}",
      publicKey: "${widget.public_key}",
      currency: this.currency,
      amount: "${widget.amount}",
      email: "${widget.amount}",
      fullName: "${widget.fullname}",
      txRef: "${widget.tx_ref}",
      isDebugMode: true,
      phoneNumber: "${widget.phone}",
      acceptCardPayment: constChannel,
      acceptUSSDPayment: constChannel,
      acceptAccountPayment: constChannel,
      acceptFrancophoneMobileMoney: false,
      acceptGhanaPayment: false,
      acceptMpesaPayment: false,
      acceptRwandaMoneyPayment: false,
      acceptUgandaPayment: false,
      acceptZambiaPayment: false,
    );

    try {
      final ChargeResponse? response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        Navigator.of(context).pop();
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          Navigator.of(context).pop();
          // provide value to customer
        } else {
          // check message
          debugPrint(response.message);

          // check status
          debugPrint(response.status);

          // check processor error
          debugPrint(response.data?.processorResponse);
        }
      }
    } catch (error) {
      // handleError(error);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data?.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data?.currency == this.currency &&
        response.data?.amount == widget.amount &&
        response.data?.txRef == widget.tx_ref;
  }

 }

