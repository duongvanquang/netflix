import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../enum/enums_firebase.dart';
import '../theme/color_theme.dart';
import '../theme/gradient_theme.dart';

class SignupScreen extends StatelessWidget {
  var _email = '';
  var _password = '';
  String? _textEmailError;
  String? _textPasswordError;

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            _checkSignUp(context, state);
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration:
                    const BoxDecoration(gradient: GradientTheme.pinkGradient),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                          image: AssetImage('assets/images/netflix_logo1.png')),
                    ),
                    Container(
                      width: 325,
                      height: 480,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(children: [
                          Text(
                            'Hello',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: NetFlixColorsTheme.primaryBlack),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            tr('signupscreen.titleaccount'),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: NetFlixColorsTheme.primaryBlack),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              onChanged: (value) => _email = value,
                              decoration: InputDecoration(
                                  labelText: tr('signupscreen.labeltextemail'),
                                  suffixIcon: const Icon(Icons.email),
                                  isDense: true,
                                  errorText: _textEmailError),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              onChanged: (value) => _password = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText:
                                      tr('signupscreen.labeltextpassword'),
                                  suffixIcon: const Icon(Icons.lock),
                                  isDense: true,
                                  errorText: _textPasswordError),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  tr('signupscreen.forget'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          color: NetFlixColorsTheme.greenColor),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => checkErrSignUp(context),
                            child: GestureDetector(
                              child: Container(
                                width: 250,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: GradientTheme.pinkGradient),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    tr('signupscreen.signup'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: NetFlixColorsTheme
                                                .primaryWhite),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  void _checkSignUp(BuildContext context, UserState state) {
    switch (state.runtimeType) {
      case UserEmailSubmitFailure:
        _textEmailError = tr('signupscreen.invalidemail');
        _textPasswordError = null;
        break;
      case UserPasswordSubmitFailure:
        _textPasswordError = tr('signupscreen.invalidpassword');
        _textEmailError = null;
        break;
      case UserAuthFailure:
        state as UserAuthFailure;
        if (state.exception == FirebaseCode.userAlreadyExists.code) {
          _textEmailError = tr('signupscreen..existaccount');
          _textPasswordError = null;
        }
        break;
      case UserSignupSuccess:
        _textEmailError = null;
        _textPasswordError = null;

        Future.delayed(const Duration(milliseconds: 200),
            () => Navigator.of(context).pushNamed('/home'));
        break;
    }
  }

  void checkErrSignUp(BuildContext context) {
    context.read<UserBloc>().add(UserSignupButtonSubmitted(
          email: _email.trim(),
          password: _password,
        ));
  }
}
