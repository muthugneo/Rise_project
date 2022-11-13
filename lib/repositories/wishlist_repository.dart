
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../app_config.dart';
import '../data_model/wishlist_check_response.dart';
import '../data_model/wishlist_delete_response.dart';
import '../data_model/wishlist_response.dart';
import '../helpers/shared_value_helper.dart';

class WishListRepository {
  Future<WishlistResponse> getUserWishlist() async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/wishlists/${user_id.$}"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );
    return wishlistResponseFromJson(response.body);
  }

  Future<WishlistDeleteResponse> delete({
    @required int wishlist_id = 0,
  }) async {
    final response = await http.delete(
      Uri.parse("${AppConfig.BASE_URL}/wishlists/$wishlist_id"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );
    return wishlistDeleteResponseFromJson(response.body);
  }

  Future<WishListChekResponse> isProductInUserWishList(
      {@required product_id = 0}) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/wishlists-check-product?product_id=$product_id&user_id=${user_id.$}"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );
    return wishListChekResponseFromJson(response.body);
  }

  Future<WishListChekResponse> add({@required product_id = 0}) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/wishlists-add-product?product_id=$product_id&user_id=${user_id.$}"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );
    return wishListChekResponseFromJson(response.body);
  }

  Future<WishListChekResponse> remove({@required product_id = 0}) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/wishlists-remove-product?product_id=$product_id&user_id=${user_id.$}"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );
    return wishListChekResponseFromJson(response.body);
  }
}
