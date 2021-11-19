import 'package:equatable/equatable.dart';
import '../../model/tvshow_model.dart';

abstract class TvshowState extends Equatable {
  const TvshowState();

  @override
  List<Object> get props => [];
}

class TvshowInitial extends TvshowState {}

class TvShowLoadInProgress extends TvshowState {}

class TvShowLoadSuccess extends TvshowState {
  final List<TVShows> airingTVShowsData;
  final List<TVShows> onTheAirTVShowData;
  final List<TVShows> popularTVShowData;
  final List<TVShows> topRedTVShowsData;
  const TvShowLoadSuccess(
      {required this.airingTVShowsData,
      required this.onTheAirTVShowData,
      required this.popularTVShowData,
      required this.topRedTVShowsData});
  @override
  List<Object> get props => [
        airingTVShowsData,
        onTheAirTVShowData,
        popularTVShowData,
        topRedTVShowsData
      ];
}

class TvShowLoadFailure extends TvshowState {
  final String error;
  const TvShowLoadFailure({required this.error});
  @override
  List<Object> get props => [error];
}
