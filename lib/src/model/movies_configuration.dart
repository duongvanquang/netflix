import '../helper/iterable_heplper.dart';

import '../helper/string_helper.dart';

enum PosterSize { small, medium, big }

enum BackdropSize { small, medium }

class ConfigurationModel {
  final String? baseUrl;
  final String? secureBaseUrl;
  final List<dynamic>? backdropSizes;
  final List<dynamic>? logoSizes;
  final List<dynamic>? posterSizes;
  final List<dynamic>? profileSizes;
  final List<dynamic>? stillSizes;
  ConfigurationModel(
      {this.baseUrl,
      this.secureBaseUrl,
      this.backdropSizes,
      this.logoSizes,
      this.posterSizes,
      this.profileSizes,
      this.stillSizes});
  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    final getBaseUrl = stringHelper(json['base_url']);
    final getSecureBaseUrl = stringHelper(json['secure_base_url']);
    final getBackdropSizes = iterableHelpers(json['backdrop_sizes']);
    final getLogoSizes = iterableHelpers(json['logo_sizes']);
    final getPosterSizes = iterableHelpers(json['poster_sizes']);
    final getProfileSizes = iterableHelpers(json['profile_sizes']);
    final getStillSizes = iterableHelpers(json['still_sizes']);

    return ConfigurationModel(
      baseUrl: getBaseUrl,
      secureBaseUrl: getSecureBaseUrl,
      backdropSizes: getBackdropSizes.toList(),
      logoSizes: getLogoSizes.toList(),
      posterSizes: getPosterSizes.toList(),
      profileSizes: getProfileSizes.toList(),
      stillSizes: getStillSizes.toList(),
    );
  }
  String? getPosterSize(PosterSize posterSize) {
    switch (posterSize) {
      case PosterSize.big:
        return '$baseUrl${posterSizes?[6]}';
      case PosterSize.medium:
        return '$baseUrl${posterSizes?[4]}';
      case PosterSize.small:
        return '$baseUrl${posterSizes?[3]}';
    }
  }

  String? getBackdropSizes(BackdropSize backdropSize) {
    switch (backdropSize) {
      case BackdropSize.medium:
        return '$baseUrl${posterSizes?[3]}';
      case BackdropSize.small:
        return '$baseUrl${posterSizes?[2]}';
    }
  }
}
