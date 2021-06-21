import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';

void main() {
  test('non empty password', () {
    final passwordValidator = NonEmptyWellFormattedStringValidator();
    expect(passwordValidator.isValidPassword('text'), true);
  });
  test('non empty email or invalid email', () {
    final passwordValidator = NonEmptyWellFormattedStringValidator();
    expect(passwordValidator.isValidEmail('text@gmail.com'), true);
  });
  test('empty password', () {
    final passwordValidator = NonEmptyWellFormattedStringValidator();
    expect(passwordValidator.isValidPassword(''), false);
  });
  test('empty email', () {
    final passwordValidator = NonEmptyWellFormattedStringValidator();
    expect(passwordValidator.isValidEmail(''), false);
  });
  test('null password', () {
    final passwordValidator = NonEmptyWellFormattedStringValidator();
    expect(passwordValidator.isValidPassword(null), false);
  });
  test('null email', () {
    final passwordValidator = NonEmptyWellFormattedStringValidator();
    expect(passwordValidator.isValidEmail(null), false);
  });
}
