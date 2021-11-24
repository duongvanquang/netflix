import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../enum/enums_firebase.dart';
import '../theme/color_theme.dart';

class LoginScreen extends StatelessWidget {
  String _email = '';
  String _password = '';
  String? _textEmailError;
  String? _textPasswordError;
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: NetFlixColorsTheme.primaryBlack,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Image(
                  width: 100,
                  height: 100,
                  image: AssetImage('assets/images/netflix_logo1.png'),
                )
              ],
            ),
            SizedBox(height: h / 8),
            Container(
              width: w / 1.2,
              height: h / 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    _checkLogIn(context, state);
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => _email = value,
                              decoration: InputDecoration(
                                labelText: tr('loginscreen.textfiledemail'),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: NetFlixColorsTheme.primaryWhite),
                                errorText: _textEmailError,
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ]);
                  },
                ),
              ),
            ),
            SizedBox(height: h / 40),
            Container(
              width: w / 1.2,
              height: h / 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    _checkLogIn(context, state);
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              onChanged: (value) => _password = value,
                              decoration: InputDecoration(
                                errorText: _textPasswordError,
                                labelText: tr('loginscreen.textfiledpassword'),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: NetFlixColorsTheme.primaryWhite),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ]);
                  },
                ),
              ),
            ),
            SizedBox(height: h / 28),
            SizedBox(
              width: w / 1.2,
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
                onPressed: () => checkErrLogin(context),
                child: Text(tr('loginscreen.buttonlogin'),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: NetFlixColorsTheme.primaryWhite)),
              ),
            ),
            SizedBox(height: h / 28),
            Text(tr('loginscreen.texthelp'),
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: NetFlixColorsTheme.primaryWhite)),
            SizedBox(height: h / 28),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Row(
                children: [
                  Text(tr('loginscreen.textsignup'),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: NetFlixColorsTheme.primaryWhite)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(tr('loginscreen.buttonsignup'),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: NetFlixColorsTheme.primaryWhite)),
                  ),
                ],
              ),
            ),
            SizedBox(height: h / 28),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Text(
                tr('loginscreen.helpsignup'),
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: NetFlixColorsTheme.primaryWhite),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _checkLogIn(BuildContext context, UserState state) {
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
        _textEmailError = null;
        _textPasswordError = null;
        if (state.exception == FirebaseCode.userNotFound.code) {
          _textEmailError = tr('loginscreen.accountnotfound');
        } else if (state.exception == FirebaseCode.userWrongPassword.code) {
          _textPasswordError = tr('loginscreen.incorrectpassword');
        }
        break;
      case UserLoginSuccess:
        _textEmailError = null;
        _textPasswordError = null;
        Future.delayed(const Duration(milliseconds: 200),
            () => Navigator.of(context).pushNamed('/home'));
        break;
    }
  }

  void checkErrLogin(BuildContext context) {
    context.read<UserBloc>().add(UserLoginButtonSubmitted(
          email: _email.trim(),
          password: _password,
        ));
  }
}
