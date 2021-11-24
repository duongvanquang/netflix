import 'package:bloc/bloc.dart';

import './user_event.dart';
import './user_state.dart';
import '../../enum/enums_firebase.dart';
import '../../services/user_services.dart';
import '../../utils/validators.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService? userService;
  UserBloc({required this.userService}) : super(UserInitial());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event.runtimeType) {
      case UserSignupButtonSubmitted:
        event as UserSignupButtonSubmitted;
        try {
          yield UserLoadInProgress();
          if (Validators.isValidEmail(event.email) &&
              Validators.isValidPassword(event.password)) {
            final status =
                await userService!.signUp(event.email, event.password);
            if (status == FirebaseCode.signUpSuccess.code) {
              yield UserSignupSuccess();
            } else {
              yield UserAuthFailure(status);
            }
          } else if (!Validators.isValidEmail(event.email)) {
            yield UserEmailSubmitFailure();
          } else if (!Validators.isValidPassword(event.password)) {
            yield UserPasswordSubmitFailure();
          }
        } on Exception {
          yield UserSignupFailure();
        }
        break;
      case UserLoginButtonSubmitted:
        event as UserLoginButtonSubmitted;
        try {
          yield UserLoadInProgress();
          if (Validators.isValidEmail(event.email) &&
              (Validators.isValidPassword(event.password))) {
            final status =
                await userService!.signIn(event.email, event.password);
            if (status == FirebaseCode.loginSuccess.code) {
              yield UserLoginSuccess();
            } else {
              yield UserAuthFailure(status);
            }
          } else if (!Validators.isValidEmail(event.email)) {
            yield UserEmailSubmitFailure();
          } else if (!Validators.isValidPassword(event.password)) {
            yield UserPasswordSubmitFailure();
          }
        } on Exception {
          yield UserSignupFailure();
        }
        break;
    }
  }
}
