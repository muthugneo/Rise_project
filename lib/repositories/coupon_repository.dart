
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../app_config.dart';
import '../data_model/coupon_apply_response.dart';
import '../data_model/coupon_remove_response.dart';
import '../helpers/shared_value_helper.dart';


class CouponRepository {
  Future<CouponApplyResponse> getCouponApplyResponse(
      @required int ownerId, @required String couponCode) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "owner_id": "$ownerId",
      "coupon_code": couponCode
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/coupon-apply"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    return couponApplyResponseFromJson(response.body);
  }

  Future<CouponRemoveResponse> getCouponRemoveResponse(
      @required int ownerId) async {
    var postBody =
        jsonEncode({"user_id": "${user_id.$}", "owner_id": "$ownerId"});
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/coupon-remove"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    return couponRemoveResponseFromJson(response.body);
  }
}
