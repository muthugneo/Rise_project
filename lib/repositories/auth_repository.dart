
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../app_config.dart';
import '../data_model/confirm_code_response.dart';
import '../data_model/login_response.dart';
import '../data_model/logout_response.dart';
import '../data_model/password_confirm_response.dart';
import '../data_model/password_forget_response.dart';
import '../data_model/resend_code_response.dart';
import '../data_model/signup_response.dart';
import '../data_model/user_by_token.dart';
import '../helpers/shared_value_helper.dart';
import '../screens/login_with_otp_response.dart';

class AuthRepository {
  Future<LoginResponse> getLoginResponse(
      @required String email, @required String password) async {
    var postBody = jsonEncode({
      "email": email,
      "password": password,
      "identity_matrix": AppConfig.purchase_code
    });

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: postBody);
    return loginResponseFromJson(response.body);
  }

  Future<LoginWithOtpResponse> getLoginWithMobResponse(
      @required String mob) async {
    var postBody = jsonEncode({
      "phone": mob,
    });
 final response = await http.post(
          Uri.parse("${AppConfig.BASE_URL}/auth/loginwithotp"),
          headers: {"Content-Type": "application/json"},
          body: postBody);
    return loginWithOtpResponseFromJson(response.body);
  }

  Future<LoginResponse> getSocialLoginResponse(@required String name,
      @required String email, @required String provider) async {
    var postBody = jsonEncode(
        {"name": name, "email": email, "provider": provider});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/social-login"),
        headers: {"Content-Type": "application/json"},
        body: postBody);
    print(response.body);
    return loginResponseFromJson(response.body);
  }

  Future<LogoutResponse> getLogoutResponse() async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/auth/logout"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );

    print(response.body);

    return logoutResponseFromJson(response.body);
  }

  Future<SignupResponse> getSignupResponse(
      @required String name,
      @required String mob,
      @required String emailOrPhone,
      @required String password,
      @required String passowrdConfirmation,
      @required String registerBy) async {
    var postBody = jsonEncode({
      "name": name,
      "phone": mob,
      "email": emailOrPhone,
      "password": password,
      "password_confirmation": passowrdConfirmation,
      "register_by": registerBy
    });

    print("aaaaaaaaaaaaaaaa : ""${AppConfig.BASE_URL}/auth/signup");
    print("aaaaaaaaaaaaaaaa : ${jsonDecode(postBody)}");

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    print("aaaaaaaaaaaaaaaa : ${response.body}");

    return signupResponseFromJson(response.body);
  }

  Future<ResendCodeResponse> getResendCodeResponse(
      @required int userId, @required String verifyBy) async {
    var postBody =
        jsonEncode({"user_id": "$userId", "register_by": verifyBy});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/resend_code"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    return resendCodeResponseFromJson(response.body);
  }

  Future<ConfirmCodeResponse> getConfirmCodeResponse(
      @required int userId, @required String verificationCode) async {
    var postBody = jsonEncode(
        {"user_id": "$userId", "verification_code": verificationCode});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/confirm_code"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    print("aaaa : $postBody");
    print("aaaa : ${response.body}");

    return confirmCodeResponseFromJson(response.body);
  }

  Future<PasswordForgetResponse> getPasswordForgetResponse(
      @required String emailOrPhone, @required String sendCodeBy) async {
    var postBody = jsonEncode(
        {"email_or_phone": emailOrPhone, "send_code_by": sendCodeBy});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/password/forget_request"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    //print(response.body.toString());

    return passwordForgetResponseFromJson(response.body);
  }

  Future<PasswordConfirmResponse> getPasswordConfirmResponse(
      @required String verificationCode, @required String password) async {
    var postBody = jsonEncode(
        {"verification_code": verificationCode, "password": password});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/password/confirm_reset"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    return passwordConfirmResponseFromJson(response.body);
  }

  Future<ResendCodeResponse> getPasswordResendCodeResponse(
      @required String emailOrCode, @required String verifyBy) async {
    var postBody = jsonEncode(
        {"email_or_code": emailOrCode, "verify_by": verifyBy});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/auth/password/resend_code"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    return resendCodeResponseFromJson(response.body);
  }

  Future<UserByTokenResponse> getUserByTokenResponse() async {
    var postBody = jsonEncode({"access_token": access_token.$});

    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/get-user-by-access_token"),
        headers: {"Content-Type": "application/json"},
        body: postBody);

    return userByTokenResponseFromJson(response.body);
  }
}
