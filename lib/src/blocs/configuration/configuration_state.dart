import 'package:equatable/equatable.dart';
import '../../model/movies_configuration.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationStartSuccess extends ConfigurationState {
  final ConfigurationModel configuration;
  const ConfigurationStartSuccess({required this.configuration});
  @override
  List<Object> get props => [configuration];
}

class ConfigurationStartFailure extends ConfigurationState {
  final String error;
  const ConfigurationStartFailure({required this.error});
  @override
  List<Object> get props => [error];
}
