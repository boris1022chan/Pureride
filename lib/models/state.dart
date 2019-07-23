import 'package:firebase_auth/firebase_auth.dart';

class StateModel {
  bool isLoading;
  bool isLogin;
  FirebaseUser user;

  StateModel({
    this.isLoading = false,
    this.isLogin = false,
    this.user,
  });
}
