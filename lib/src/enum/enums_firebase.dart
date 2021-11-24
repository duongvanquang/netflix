enum FirebaseCode {
  userNotFound,
  userAlreadyExists,
  userWrongPassword,
  accountExistWithDifferentCredential,
  userDisabled,
  operationNotAllowed,
  resetPasswordRequested,
  loginSuccess,
  signUpSuccess,
}

extension throwValueCode on FirebaseCode {
  String get code {
    switch (this) {
      case FirebaseCode.resetPasswordRequested:
        return 'reset-password-requested';
      case FirebaseCode.userNotFound:
      case FirebaseCode.accountExistWithDifferentCredential:
        return 'user-not-found';
      case FirebaseCode.userAlreadyExists:
        return 'email-already-in-use';
      case FirebaseCode.userDisabled:
        return 'user-disabled';
      case FirebaseCode.userWrongPassword:
        return 'wrong-password';
      case FirebaseCode.operationNotAllowed:
        return 'operation-not-allowed';
      case FirebaseCode.loginSuccess:
        return 'login-success';
      case FirebaseCode.signUpSuccess:
        return 'sign-up-success';
    }
  }
}
