import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/configuration_services.dart';

import 'configuration_event.dart';
import 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationServices? configurationServices;
  ConfigurationBloc({required this.configurationServices})
      : super(ConfigurationInitial());
  @override
  Stream<ConfigurationState> mapEventToState(ConfigurationEvent event) async* {
    switch (event.runtimeType) {
      case ConfigurationStarted:
        try {
          final configation =
              await configurationServices!.getImageConfiguration();
          yield ConfigurationStartSuccess(configuration: configation);
        } on Exception {
          yield ConfigurationStartFailure(
              error: tr('homescreen.configurationfailure'));
        }
    }
  }
}
