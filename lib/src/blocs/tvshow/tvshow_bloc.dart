import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/api_services.dart';

import 'tvshow_event.dart';
import 'tvshow_state.dart';

class TvshowBloc extends Bloc<TvshowEvent, TvshowState> {
  final ApiService? apiService;
  TvshowBloc({required this.apiService}) : super(TvshowInitial());
  @override
  Stream<TvshowState> mapEventToState(TvshowEvent event) async* {
    switch (event.runtimeType) {
      case TvShowLoaded:
        try {
          yield TvShowLoadInProgress();
          final tvShowDataAiring = await apiService!.getAiringTVShowsData();
          final tvShowDataOntheAir = await apiService!.getOnTheAirTVShowData();
          final tvShowDataPopular = await apiService!.getPopularTVShowData();
          final tvShowDataTopRed = await apiService!.getTopRedTVShowsData();
          yield TvShowLoadSuccess(
              airingTVShowsData: tvShowDataAiring,
              onTheAirTVShowData: tvShowDataOntheAir,
              popularTVShowData: tvShowDataPopular,
              topRedTVShowsData: tvShowDataTopRed);
        } on Exception {
          yield TvShowLoadFailure(error: tr('tvshowbloc.statefailure'));
        }
    }
  }
}
