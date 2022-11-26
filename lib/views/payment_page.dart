// import 'package:flutter/material.dart';
// import 'package:flutterwave/flutterwave.dart';
// import 'package:flutterwave/models/responses/charge_response.dart';
// import 'package:luxpay/views/paymentMethod/paymentSuccessful.dart';
// import 'package:luxpay/widgets/methods/showDialog.dart';

// beginPayment(
//     {encryption_key,
//     public_key,
//     amount,
//     email,
//     tx_ref,
//     phone,
//     fullname,
//     context}) async {
//   final Flutterwave flutterwave = Flutterwave.forUIPayment(
//     context: context,
//     encryptionKey: encryption_key,
//     publicKey: public_key,
//     currency: FlutterwaveCurrency.NGN,
//     amount: amount,
//     email: email,
//     fullName: fullname,
//     txRef: tx_ref,
//     isDebugMode: false,
//     phoneNumber: phone,
//     acceptCardPayment: true,
//     acceptUSSDPayment: false,
//     acceptAccountPayment: false,
//     acceptFrancophoneMobileMoney: false,
//     acceptGhanaPayment: false,
//     acceptMpesaPayment: false,
//     acceptRwandaMoneyPayment: false,
//     acceptUgandaPayment: false,
//     acceptZambiaPayment: false,
//   );

//   try {
//     final ChargeResponse? response =
//         await flutterwave.initializeForUiPayments();
//     if (response == null) {
//       // Navigator.of(context).pop();
//       showErrorDialog(context, "Incomplete Transaction try again", "Luxpay");
//       // user didn't complete the transaction.

//     } else {
//       final isSuccessful = checkPaymentIsSuccessful(response, amount, tx_ref);
//       if (isSuccessful) {
//         // Navigator.of(context).pop();
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => SuccessfullPayment()));
//         // provide value to customer
//       } else {
//         // check message
//         debugPrint(response.message);

//         // check status
//         debugPrint(response.status);

//         // check processor error
//         debugPrint(response.data?.processorResponse);
//       }
//     }
//   } catch (error) {
//     // handleError(error);
//     debugPrint(error.toString());
//   }
// }

// bool checkPaymentIsSuccessful(final ChargeResponse response, amount, txRef) {
//   return response.data?.status == FlutterwaveConstants.SUCCESSFUL &&
//       response.data?.currency == FlutterwaveCurrency.NGN &&
//       response.data?.amount == amount &&
//       response.data?.txRef == txRef;
// }
