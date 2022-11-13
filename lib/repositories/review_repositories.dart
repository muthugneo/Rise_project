
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../app_config.dart';
import '../data_model/review_response.dart';
import '../data_model/review_submit_response.dart';
import '../helpers/shared_value_helper.dart';

class ReviewRepository {
  Future<ReviewResponse> getReviewResponse(@required int productId,
      {page = 1}) async {
    //print(product_id.toString()+"hehehe");
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/reviews/product/$productId?page=$page"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}"
      },
    );
    return reviewResponseFromJson(response.body);
  }

  Future<ReviewSubmitResponse> getReviewSubmitResponse(
    @required int productId,
    @required int rating,
    @required String comment,
  ) async {
    var postBody = jsonEncode({
      "product_id": "$productId",
      "user_id": "${user_id.$}",
      "rating": "$rating",
      "comment": comment
    });
    print(postBody.toString());
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/reviews/submit"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    return reviewSubmitResponseFromJson(response.body);
  }
}
