import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class PaymentWidget extends StatefulWidget {
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final String txref = "My_unique_transaction_reference_123";
  final String amount = "200";
  final String currency = FlutterwaveCurrency.NGN;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      beginPayment();
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
      encryptionKey: "a905077546d2ff8a3e88fa6e",
      publicKey: "FLWPUBK-2966e9a8cdd603a66935b76e6fa0d9c9-X",
      currency: this.currency,
      amount: this.amount,
      email: "valid@email.com",
      fullName: "Valid Full Name",
      txRef: this.txref,
      isDebugMode: true,
      phoneNumber: "0123456789",
      acceptCardPayment: true,
      acceptUSSDPayment: true,
      acceptAccountPayment: true,
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
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data?.processorResponse);
        }
      }
    } catch (error) {
      // handleError(error);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data?.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data?.currency == this.currency &&
        response.data?.amount == this.amount &&
        response.data?.txRef == this.txref;
  }
}
