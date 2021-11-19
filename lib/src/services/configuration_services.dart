import 'dart:convert';

import '../constants/api_constans.dart';
import '../model/movies_configuration.dart';
import 'http_client.dart';

class ConfigurationServices {
  Future<ConfigurationModel> getImageConfiguration() async {
    final bodyConfiguration = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/configuration', {'api_key': ApiConstant.apiKey});
    final Map getConfiguration = json.decode(bodyConfiguration);
    return ConfigurationModel.fromJson(getConfiguration['images']);
  }
}
