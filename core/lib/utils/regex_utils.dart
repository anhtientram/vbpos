part of '../core.dart';

class RegexUtils {
  static final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z0-9._]{3,}$');
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$',
  );
  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  static final RegExp _phoneRegExp = RegExp(r'^0[35789][0-9]{8}$');
  static final RegExp _identityCardRegExp = RegExp(r'^\d{12}$');

  static bool isUsernameValid(String userName) {
    return _usernameRegExp.hasMatch(userName);
  }

  static bool isPasswordValid(String pw) {
    return _passwordRegExp.hasMatch(pw);
  }

  static bool isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNo) {
    return _phoneRegExp.hasMatch(phoneNo);
  }

  static bool isIdentityCardValid(String identityNo) {
    return _identityCardRegExp.hasMatch(identityNo);
  }
}
