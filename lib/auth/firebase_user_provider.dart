import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class IcarttestFirebaseUser {
  IcarttestFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

IcarttestFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<IcarttestFirebaseUser> icarttestFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<IcarttestFirebaseUser>(
        (user) => currentUser = IcarttestFirebaseUser(user));
