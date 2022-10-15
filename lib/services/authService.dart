// import 'package:local_auth/local_auth.dart';

// class BiometricHelper {
//   final LocalAuthentication _auth = LocalAuthentication();

//   Future<bool> hasEnrolledBiometrics() async {
//     final List<BiometricType> availableBiometrics =
//         await _auth.getAvailableBiometrics();

//     if (availableBiometrics.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }

//   Future<bool> checkBiometrics() async {
//     late bool canCheckBiometrics;
//     try {
//       canCheckBiometrics = await _auth.canCheckBiometrics;
//       return canCheckBiometrics;
//     } catch (e) {
//       canCheckBiometrics = false;
//       print(e);
//       return canCheckBiometrics;
//     }
//   }

//   Future<bool> authenticateWithBiometrics() async {
//     bool authenticate = false;
//     try {
//       authenticate = await _auth.authenticate(
//         localizedReason:
//             'Scan your fingerprint (or face or whatever) to authenticate',
//         biometricOnly: true,
//         useErrorDialogs: true,
//         stickyAuth: true,
//       );

//       return authenticate;
//     } catch (e) {
//       print(e);
//       authenticate = false;
//       return authenticate;
//     }
//   }

//   Future<bool> authenticate() async {
//     final bool didAuthenticate = await _auth.authenticate(
//       localizedReason: 'Please authenticate to proceed',
//       biometricOnly: true,
//       useErrorDialogs: true,
//       stickyAuth: true,
//     );
//     return didAuthenticate;
//   }
// }
