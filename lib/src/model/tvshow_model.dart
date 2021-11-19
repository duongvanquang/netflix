import '../helper/iterable_heplper.dart';

import '../helper/string_helper.dart';

class TVShows {
  final String? backdropPath;
  final String? firstAirDate;
  final List? genreIDs;
  final int id;
  final String? name;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final int? voteCount;

  TVShows({
    required this.id,
    this.backdropPath,
    this.firstAirDate,
    this.genreIDs,
    this.name,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.posterPath,
    this.voteCount,
  });

  factory TVShows.fromJson(Map<String, dynamic> json) {
    var getId = json['id'];
    if (json['id'] != null) {
      getId = json['id'];
    }
    final getBackDropPath = stringHelper(json['backdrop_path']);
    final getName = stringHelper(json['name']);
    final getFirstAirDate = stringHelper(json['first_air_date']);
    final getGenreIDs = iterableHelpers(json['genre_ids']);
    final getOriginalName = stringHelper(json['original_name']);
    final getOriginalLanguage = stringHelper(json['original_language']);
    final getOverview = stringHelper(json['overview']);
    final getPosterPath = stringHelper(json['poster_path']);
    final getVoteCount = json['vote_count'];

    return TVShows(
      backdropPath: getBackDropPath,
      firstAirDate: getFirstAirDate.toString(),
      genreIDs: getGenreIDs.toList(),
      id: getId,
      name: getName.toString(),
      originalName: getOriginalName.toString(),
      originalLanguage: getOriginalLanguage,
      overview: getOverview,
      posterPath: getPosterPath,
      voteCount: getVoteCount,
    );
  }
}
