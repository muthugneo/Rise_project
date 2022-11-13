
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter/foundation.dart';

import '../app_config.dart';
import '../data_model/address_add_response.dart';
import '../data_model/address_delete_response.dart';
import '../data_model/address_make_default_response.dart';
import '../data_model/address_response.dart';
import '../data_model/address_update_in_cart_response.dart';
import '../data_model/address_update_response.dart';
import '../data_model/city_response.dart';
import '../data_model/country_response.dart';
import '../data_model/shipping_cost_response.dart';
import '../helpers/shared_value_helper.dart';

class AddressRepository {
  Future<AddressResponse> getAddressList() async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/user/shipping/address/${user_id.$}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}"
      },
    );
    print(response.body.toString());
    return addressResponseFromJson(response.body);
  }

  Future<AddressAddResponse> getAddressAddResponse(
      @required String address,
      @required String country,
      @required String city,
      @required String postalCode,
      @required String phone) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "address": address,
      "country": country,
      "city": city,
      "postal_code": postalCode,
      "phone": phone
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/user/shipping/create"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    return addressAddResponseFromJson(response.body);
  }

  Future<AddressUpdateResponse> getAddressUpdateResponse(
      @required int id,
      @required String address,
      @required String country,
      @required String city,
      @required String postalCode,
      @required String phone) async {
    var postBody = jsonEncode({
      "id": "$id",
      "user_id": "${user_id.$}",
      "address": address,
      "country": country,
      "city": city,
      "postal_code": postalCode,
      "phone": phone
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/user/shipping/update"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    return addressUpdateResponseFromJson(response.body);
  }

  Future<AddressMakeDefaultResponse> getAddressMakeDefaultResponse(
    @required int id,
  ) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "id": "$id",
    });
    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/user/shipping/make_default"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);

    return addressMakeDefaultResponseFromJson(response.body);
  }

  Future<AddressDeleteResponse> getAddressDeleteResponse(
    @required int id,
  ) async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/user/shipping/delete/$id"),
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );

    return addressDeleteResponseFromJson(response.body);
  }

  Future<CityResponse> getCityList() async {
    final response = await http.get(Uri.parse("${AppConfig.BASE_URL}/cities"));

    return cityResponseFromJson(response.body);
  }

  Future<CountryResponse> getCountryList() async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/countries"));
    return countryResponseFromJson(response.body);
  }

  Future<ShippingCostResponse> getShippingCostResponse(@required int ownerId,
      @required int userId, @required String cityName) async {
    var postBody = jsonEncode({
      "owner_id": "$ownerId",
      "user_id": "$userId",
      "city_name": cityName
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/shipping_cost"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${access_token.$}"
            },
            body: postBody);

    //(post_body.toString());

    return shippingCostResponseFromJson(response.body);
  }

  Future<AddressUpdateInCartResponse> getAddressUpdateInCartResponse(
    @required int addressId,
  ) async {
    var postBody = jsonEncode(
        {"address_id": "$addressId", "user_id": "${user_id.$}"});
    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/update-address-in-cart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);

    return addressUpdateInCartResponseFromJson(response.body);
  }
}
