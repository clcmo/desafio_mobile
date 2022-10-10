import 'package:auth/auth.dart';
import 'package:challenge/services/auth_services.dart';
import 'package:challenge/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  get onAuthStateChanged => Status.unauthenticated;
}

class MockFirebaseUser extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements UserCredential {}

void main() {
  MockFirebaseAuth _auth = MockFirebaseAuth();
  LoginPage _activity = const LoginPage();
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  when(_auth.onAuthStateChanged).thenAnswer((_) {
    return _user;
  });

  AuthService _repo = AuthService.instance(auth: _auth);
  group('user repository test', () {
    when(_auth.signInWithEmailAndPassword(email: "email", password: "password"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });
    when(_auth.signInWithEmailAndPassword(email: "mail", password: "pass"))
        .thenThrow(() => null);
    test("sign in with email and password", () async {
      bool signedIn = await _repo.login("email", "password", _activity);
      expect(signedIn, true);
      expect(_repo.status, Status.authenticated);
    });

    test("sing in fails with incorrect email and password", () async {
      bool signedIn = await _repo.login("mail", "pass", _activity);
      expect(signedIn, false);
      expect(_repo.status, Status.unauthenticated);
    });

    test('sign out', () async {
      await _repo.logout();
      expect(_repo.status, Status.unauthenticated);
    });
  });
}
