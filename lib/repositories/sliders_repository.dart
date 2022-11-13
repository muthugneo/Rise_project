
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/slider_response.dart';

class SlidersRepository {
  Future<SliderResponse> getSliders() async {
    final response = await http.get(Uri.parse("${AppConfig.BASE_URL}/sliders"));
    return sliderResponseFromJson(response.body);
  }
}
