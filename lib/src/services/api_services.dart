import 'dart:convert';

import '../constants/api_constans.dart';
import '../model/tvshow_model.dart';
import 'http_client.dart';

class ApiService {
  Future<List<TVShows>> getAiringTVShowsData() async {
    final bodyTVShowsData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/tv/airing_today', {
      'api_key': ApiConstant.apiKey,
    });
    final getTVshowData = json.decode(bodyTVShowsData);
    final List responseList =
        Map<String, dynamic>.from(getTVshowData)['results'];
    return responseList.map<TVShows>((json) => TVShows.fromJson(json)).toList();
  }

  Future<List<TVShows>> getOnTheAirTVShowData() async {
    final bodyTVShowData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/tv/on_the_air', {'api_key': ApiConstant.apiKey});
    final getTVshowdata = json.decode(bodyTVShowData);
    final List responseList =
        Map<String, dynamic>.from(getTVshowdata)['results'];
    return responseList.map<TVShows>((json) => TVShows.fromJson(json)).toList();
  }

  Future<List<TVShows>> getPopularTVShowData() async {
    final bodyTVShowData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/tv/popular', {'api_key': ApiConstant.apiKey});
    final getTVshowData = json.decode(bodyTVShowData);
    final List responseList =
        Map<String, dynamic>.from(getTVshowData)['results'];
    return responseList.map<TVShows>((json) => TVShows.fromJson(json)).toList();
  }

  Future<List<TVShows>> getTopRedTVShowsData() async {
    final bodyTVShowsData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/tv/top_rated', {
      'api_key': ApiConstant.apiKey,
    });
    final getTVshowData = json.decode(bodyTVShowsData);
    final List responseList =
        Map<String, dynamic>.from(getTVshowData)['results'];
    return responseList.map<TVShows>((json) => TVShows.fromJson(json)).toList();
  }
}
