import 'package:equatable/equatable.dart';

abstract class TvshowEvent extends Equatable {
  const TvshowEvent();

  @override
  List<Object> get props => [];
}

class TvShowLoaded extends TvshowEvent {}
