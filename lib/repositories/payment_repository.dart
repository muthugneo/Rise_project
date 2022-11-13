
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../app_config.dart';
import '../data_model/bkash_begin_response.dart';
import '../data_model/bkash_payment_process_response.dart';
import '../data_model/iyzico_payment_success_response.dart';
import '../data_model/nagad_begin_response.dart';
import '../data_model/nagad_payment_process_response.dart';
import '../data_model/order_create_response.dart';
import '../data_model/payment_type_response.dart';
import '../data_model/paypal_url_response.dart';
import '../data_model/paystack_payment_success_response.dart';
import '../data_model/razorpay_payment_success_response.dart';
import '../helpers/shared_value_helper.dart';

class PaymentRepository {
  Future<List<PaymentTypeResponse>> getPaymentResponseList({mode = ""}) async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/payment-types?mode=$mode"),
    );

    return paymentTypeResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponse(
      @required int ownerId, @required paymentMethod) async {
    var postBody = jsonEncode({
      "owner_id": "$ownerId",
      "user_id": "${user_id.$}",
      "payment_type": "$paymentMethod"
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/order/store"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<PaypalUrlResponse> getPaypalUrlResponse(@required String paymentType,
      @required int orderId, @required double amount) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/paypal/payment/url?payment_type=$paymentType&order_id=$orderId&amount=$amount&user_id=${user_id.$}"),
    );

    print(response.body.toString());
    return paypalUrlResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromWallet(
      @required int ownerId,
      @required paymentMethod,
      @required double amount) async {
    var postBody = jsonEncode({
      "owner_id": "$ownerId",
      "user_id": "${user_id.$}",
      "payment_type": "$paymentMethod",
      "amount": "$amount"
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/payments/pay/wallet"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromCod(
      @required int ownerId, @required paymentMethod) async {
    var postBody = jsonEncode({
      "owner_id": "$ownerId",
      "user_id": "${user_id.$}",
      "payment_type": "$paymentMethod"
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/payments/pay/cod"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<RazorpayPaymentSuccessResponse> getRazorpayPaymentSuccessResponse(
      @required paymentType,
      @required double amount,
      @required int orderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "order_id": "$orderId",
      "amount": "$amount",
      "payment_details": paymentDetails
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/razorpay/success"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return razorpayPaymentSuccessResponseFromJson(response.body);
  }

  Future<PaystackPaymentSuccessResponse> getPaystackPaymentSuccessResponse(
      @required paymentType,
      @required double amount,
      @required int orderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "order_id": "$orderId",
      "amount": "$amount",
      "payment_details": paymentDetails
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/paystack/success"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return paystackPaymentSuccessResponseFromJson(response.body);
  }

  Future<IyzicoPaymentSuccessResponse> getIyzicoPaymentSuccessResponse(
      @required paymentType,
      @required double amount,
      @required int orderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "order_id": "$orderId",
      "amount": "$amount",
      "payment_details": paymentDetails
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/paystack/success"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return iyzicoPaymentSuccessResponseFromJson(response.body);
  }

  Future<BkashBeginResponse> getBkashBeginResponse(
      @required String paymentType,
      @required int orderId,
      @required double amount) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/bkash/begin?payment_type=$paymentType&order_id=$orderId&amount=$amount&user_id=${user_id.$}"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );

    print(response.body.toString());
    return bkashBeginResponseFromJson(response.body);
  }

  Future<BkashPaymentProcessResponse> getBkashPaymentProcessResponse(
      @required paymentType,
      @required double amount,
      @required int orderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "order_id": "$orderId",
      "amount": "$amount",
      "payment_details": paymentDetails
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/bkash/process"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return bkashPaymentProcessResponseFromJson(response.body);
  }

  Future<NagadBeginResponse> getNagadBeginResponse(
      @required String paymentType,
      @required int orderId,
      @required double amount) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/nagad/begin?payment_type=$paymentType&order_id=$orderId&amount=$amount&user_id=${user_id.$}"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );

    print(response.body.toString());
    return nagadBeginResponseFromJson(response.body);
  }

  Future<NagadPaymentProcessResponse> getNagadPaymentProcessResponse(
      @required paymentType,
      @required double amount,
      @required int orderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "order_id": "$orderId",
      "amount": "$amount",
      "payment_details": paymentDetails
    });

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/nagad/process"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //print(response.body.toString());
    return nagadPaymentProcessResponseFromJson(response.body);
  }
}
