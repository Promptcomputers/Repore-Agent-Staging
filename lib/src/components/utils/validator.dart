import 'package:repore_agent/lib.dart';

class Validator {
  static String? validateEmail(String? s) {
    if (FormStringUtils.isEmpty(s)) {
      return 'Email cannot be empty';
    } else if (!FormStringUtils.isValidEmail(s!)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? validateUrl(String? s) {
    if (FormStringUtils.isEmpty(s)) {
      return 'Url link cannot be empty';
    } else if (!FormStringUtils.isValidUrl(s!)) {
      return 'Enter a valid url';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? s) {
    if (FormStringUtils.isEmpty(s)) {
      return 'Password cannot be empty';
    } else if (s!.length < 4) {
      return 'Password must be greater than four characters';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? s, String? password) {
    if (FormStringUtils.isEmpty(s)) {
      return 'Confirm Password cannot be empty';
    } else if (s != password) {
      return 'Password doesn\'t match';
    } else {
      return null;
    }
  }

  static String? validateUsername(String? s) {
    if (FormStringUtils.isEmpty(s)) {
      return 'Username cannot be empty';
    } else if (FormStringUtils.hasUpperCase(s!)) {
      return 'Username must be in lowercase';
    } else {
      return null;
    }
  }

  static String? validateField(String? s, {String? errorMessage}) {
    if (FormStringUtils.isEmpty(s)) {
      return errorMessage;
    } else {
      return null;
    }
  }

  static String? phoneNunber(String? s, {String? errorMessage}) {
    if (FormStringUtils.isEmpty(s)) {
      return errorMessage;
    } else if (s!.length > 11) {
      return 'Phone number is incorrect';
    } else {
      return null;
    }
  }
}
