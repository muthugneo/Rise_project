
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../app_config.dart';
import '../data_model/product_details_response.dart';
import '../data_model/product_mini_response.dart';
import '../data_model/variant_response.dart';

class ProductRepository {
  Future<ProductMiniResponse> getFeaturedProducts() async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/products/featured"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getBestSellingProducts() async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/products/best-seller"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getTodaysDealProducts() async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/products/todays-deal"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getFlashDealProducts(
      {@required int id = 0}) async {
    final response = await http.get(Uri.parse(
        "${AppConfig.BASE_URL}/flash-deal-products/$id"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getCategoryProducts(
      {@required int id = 0, name = "", page = 1}) async {
    final response = await http.get(Uri.parse(
        "${AppConfig.BASE_URL}/products/category/$id?page=$page&name=$name"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getShopProducts(
      {@required int id = 0, name = "", page = 1}) async {
    var url = "${AppConfig.BASE_URL}/products/seller/$id?page=$page&name=$name";

    final response = await http.get(Uri.parse(url));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getBrandProducts(
      {@required int id = 0, name = "", page = 1}) async {
    final response = await http.get(Uri.parse(
        "${AppConfig.BASE_URL}/products/brand/$id?page=$page&name=$name"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getFilteredProducts(
      {name = "",
      sort_key = "",
      page = 1,
      brands = "",
      categories = "",
      min = "",
      max = ""}) async {
    var url = "${AppConfig.BASE_URL}/products/search" "?page=$page&name=$name&sort_key=$sort_key&brands=$brands&categories=$categories&min=$min&max=$max";

    //print("url:" + url);
    final response = await http.get(Uri.parse(url));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductDetailsResponse> getProductDetails(
      {@required int id = 0}) async {
    final response = await http
        .get(Uri.parse("${AppConfig.BASE_URL}/products/$id"));
    return productDetailsResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getRelatedProducts({@required int id = 0}) async {
    final response = await http.get(
        Uri.parse("${AppConfig.BASE_URL}/products/related/$id"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getTopFromThisSellerProducts(
      {@required int id = 0}) async {
    final response = await http.get(Uri.parse(
        "${AppConfig.BASE_URL}/products/top-from-seller/$id"));
    return productMiniResponseFromJson(response.body);
  }

  Future<VariantResponse> getVariantWiseInfo(
      {int id = 0, color = '', variants = ''}) async {
    var url =
        "${AppConfig.BASE_URL}/products/variant/price?id=${id.toString()}&color=$color&variants=$variants";

    final response = await http.get(Uri.parse(url));

    print("url:$url");
    print("body -------");
    print(response.body);
    print("body end -------");
    return variantResponseFromJson(response.body);
  }
}
