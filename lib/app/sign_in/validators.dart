import 'dart:core';

abstract class StringValidator {
  bool isValidPassword(String value);
  bool isValidEmail(String value);
}

class NonEmptyWellFormattedStringValidator implements StringValidator {
  @override
  bool isValidPassword(String value) {
    if(value == null) return false;
    return value.isNotEmpty;
  }

  @override
  bool isValidEmail(String value) {
    if(value == null) return false;
    return value.isNotEmpty &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value);
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyWellFormattedStringValidator();
  final StringValidator passwordValidator =
      NonEmptyWellFormattedStringValidator();
  final String invalidEmailErrorText = 'Please enter your email';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
