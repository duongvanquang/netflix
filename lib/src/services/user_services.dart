import 'package:firebase_auth/firebase_auth.dart';
import '../enum/enums_firebase.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return FirebaseCode.loginSuccess.code;
    } on FirebaseException catch (exception) {
      return exception.code;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return FirebaseCode.signUpSuccess.code;
    } on FirebaseAuthException catch (exception) {
      return exception.code;
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );
      return FirebaseCode.resetPasswordRequested.code;
    } on FirebaseAuthException catch (exception) {
      return exception.code;
    }
  }
}
