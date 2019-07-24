import 'package:firebase_auth/firebase_auth.dart';

class StateModel {
  bool isLoading;
  bool isLogin;
  FirebaseUser user;
  int selectedId;
  final Map<int, Function> addMeSubscribers = {};
  final username;

  StateModel({
    this.isLoading = false,
    this.isLogin = false,
    this.user,
    this.username = 'Boris Chan'
  });

  updateAddMeSubscribers() => this.addMeSubscribers.forEach((id, fn) => fn());
}
