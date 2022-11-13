
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../app_config.dart';
import '../data_model/cart_add_response.dart';
import '../data_model/cart_delete_response.dart';
import '../data_model/cart_process_response.dart';
import '../data_model/cart_response.dart';
import '../data_model/cart_summary_response.dart';
import '../helpers/shared_value_helper.dart';


class CartRepository {
  Future<List<CartResponse>> getCartResponseList(
    @required int userId,
  ) async {
    final response = await http.post(
      Uri.parse("${AppConfig.BASE_URL}/carts/$userId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}"
      },
    );

    return cartResponseFromJson(response.body);
  }

  Future<CartDeleteResponse> getCartDeleteResponse(
    @required int cartId,
  ) async {
    final response = await http.delete(
      Uri.parse("${AppConfig.BASE_URL}/carts/$cartId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}"
      },
    );

    return cartDeleteResponseFromJson(response.body);
  }

  Future<CartProcessResponse> getCartProcessResponse(
      @required String cartIds, @required String cartQuantities) async {
    var postBody = jsonEncode(
        {"cart_ids": cartIds, "cart_quantities": cartQuantities});
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/carts/process"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    return cartProcessResponseFromJson(response.body);
  }

  Future<CartAddResponse> getCartAddResponse(
      @required int id,
      @required String variant,
      @required int userId,
      @required int quantity) async {
    var postBody = jsonEncode({
      "id": "$id",
      "variant": variant,
      "user_id": "$userId",
      "quantity": "$quantity",
      "cost_matrix": AppConfig.purchase_code
    });

    print(postBody.toString());

    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/carts/add"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    print(response.body.toString());
    return cartAddResponseFromJson(response.body);
  }

  Future<CartSummaryResponse> getCartSummaryResponse(@required ownerId) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/cart-summary/${user_id.$}/$ownerId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}"
      },
    );

    return cartSummaryResponseFromJson(response.body);
  }
}
