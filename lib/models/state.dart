import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class StateModel {
  bool isLoading;
  FirebaseUser user;

  StateModel({
    this.isLoading = false,
    this.user,
  });
}
