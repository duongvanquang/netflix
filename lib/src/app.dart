import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/configuration/configuration_bloc.dart';
import 'blocs/tvshow/tvshow_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'screens/bottom_navigator_screen.dart';
import 'screens/gamescreen.dart';
import 'screens/homescreen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'services/api_services.dart';
import 'services/configuration_services.dart';
import 'services/user_services.dart';
import 'theme/netflix_theme.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _configarutionBloc =
      ConfigurationBloc(configurationServices: ConfigurationServices());
  final _tvshowBloc = TvshowBloc(apiService: ApiService());
  final _userBloc = UserBloc(userService: UserService());
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _configarutionBloc),
          BlocProvider.value(value: _tvshowBloc),
          BlocProvider.value(value: _userBloc)
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: NetFlixTheme.buildTheme(),
          routes: {
            '/': (context) => LoginScreen(),
            '/bottom_navigator': (context) => const BottomNavigator(),
            '/home': (context) => const HomeScreen(),
            '/game': (context) => const GameScreen(),
            '/signup': (context) => SignupScreen()
          },
        ),
      );
}
