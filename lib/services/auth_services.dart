import 'package:challenge/error_handler.dart';
import 'package:challenge/ui/home_page.dart';
import 'package:challenge/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AuthService with ChangeNotifier {
  Status _status = Status.uninitialized;
  late FirebaseAuth _user;

  handleAuth() => StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) =>
          snapshot.hasData ? HomePage() : LoginPage());

  Status get status => _status;

  //Sair
  Future singOut() async {
    FirebaseAuth.instance.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  singIn(String email, String password, context) => FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((val) {
        print('Logado');
      }).catchError((e) {
        ErrorHandler().errorDialog(context, e);
      });

  fbSignIn() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        final result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }

  signUp(String email, String password) => FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

  resetPasswordLink(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  Future<void> onAuthStateChanged(FirebaseAuth firebaseUser) async {
    _status =
        firebaseUser == null ? Status.unauthenticated : Status.authenticated;
    notifyListeners();
  }
}
