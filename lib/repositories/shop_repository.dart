
import 'package:http/http.dart' as http;


import '../app_config.dart';
import '../data_model/product_mini_response.dart';
import '../data_model/shop_details_response.dart';
import '../data_model/shop_response.dart';

class ShopRepository {
  Future<ShopResponse> getShops({name = "", page = 1}) async {
    final response = await http.get(Uri.parse(
        "${AppConfig.BASE_URL}/shops" "?page=$page&name=$name"));
    return shopResponseFromJson(response.body);
  }

  Future<ShopDetailsResponse> getShopInfo({ id = 0}) async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/shops/details/$id"));
    return shopDetailsResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getTopFromThisSellerProducts({int id = 0}) async {
    final response = await http.get(
        Uri.parse("${AppConfig.BASE_URL}/shops/products/top/$id"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getNewFromThisSellerProducts({int id = 0}) async {
    final response = await http.get(
        Uri.parse("${AppConfig.BASE_URL}/shops/products/new/$id"));
    return productMiniResponseFromJson(response.body);
  }

  Future<ProductMiniResponse> getfeaturedFromThisSellerProducts(
      {int id = 0}) async {
    final response = await http.get(Uri.parse(
        "${AppConfig.BASE_URL}/shops/products/featured/$id"));
    return productMiniResponseFromJson(response.body);
  }
}
