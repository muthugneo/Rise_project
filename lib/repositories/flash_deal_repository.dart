
import 'package:http/http.dart' as http;


import '../app_config.dart';
import '../data_model/flash_deal_response.dart';

class FlashDealRepository {
  Future<FlashDealResponse> getFlashDeals() async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/flash-deals"));
    return flashDealResponseFromJson(response.body);
  }
}
