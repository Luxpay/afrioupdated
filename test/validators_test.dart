import 'package:flutter_test/flutter_test.dart';
import 'package:luxpay/utils/validators.dart';

void main() {
  group("Test validators", () {
    test("Test phone number validator", () {
      expect(Validators.isValidPhoneNumber("090913018"),
          "Please enter a valid phone number");
      expect(Validators.isValidPhoneNumber("9091301846"), null);
      expect(Validators.isValidPhoneNumber("09091301846"), null);
    });
  });
}
