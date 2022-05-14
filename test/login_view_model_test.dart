import 'package:flutter_test/flutter_test.dart';
import 'package:luxpay/utils/validators.dart';

void main() {
  setUp(
    () {},
  );
  group('LoginViewModel', () {
    test('should return string when email is empty', () {
      expect(Validators.isValidEmail(''), 'Email cannot be empty');
    });
    test('should return string when password is empty', () {
      expect(Validators.isValidPassword(''), 'Password cannot be empty');
    });

    test("Should return validate email if not empty", () {
      expect(Validators.isValidEmail('a@gmail'),
          'Please enter a valid email address');
      expect(Validators.isValidEmail('agmail'),
          'Please enter a valid email address');
      expect(Validators.isValidEmail('a@gmail.com'), null);
      expect(Validators.isValidEmail('a@gmail.com.ng'), null);
    });

    test('should validate password', () {
      expect(Validators.isValidPassword('12345'),
          'Password must be at least 6 characters');
      expect(Validators.isValidPassword('123456'), null);
    });
  });
}
