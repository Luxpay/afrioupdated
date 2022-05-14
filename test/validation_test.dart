import 'package:flutter_test/flutter_test.dart';
import 'package:luxpay/utils/functions.dart';

void main() {
  setUp(() {});

  group("Run validation checks", () {
    test("Check that countdown string is correct", () {
      expect("00:59", getTimeForCountDown(59));
      expect("01:59", getTimeForCountDown(119));
      expect("02:00", getTimeForCountDown(120));
      expect("01:00", getTimeForCountDown(60));
    });

    test("Check that email obscuring works", () {
      expect("e********69@gmail.com", obscureEmail("ezechukwu69@gmail.com"));
    });
  });
}
