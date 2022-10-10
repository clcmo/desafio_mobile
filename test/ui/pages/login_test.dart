import 'dart:js';

import 'package:challenge/services/auth_services.dart';
import 'package:challenge/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockUserRepository extends Mock implements AuthService {
  final MockFirebaseAuth auth;
  MockUserRepository({required this.auth});
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  MockFirebaseAuth _auth = MockFirebaseAuth();
  MockUserRepository _repo;
  _repo = MockUserRepository(auth: _auth);
  Widget _makeTestable(Widget child) =>
      ChangeNotifierProvider<AuthService>.value(
        value: _repo,
        child: MaterialApp(
          home: child,
        ),
      );
  var emailField = find.byKey(const Key("email-field"));
  var passwordField = find.byKey(const Key("password-field"));
  var signInButton = find.text("Sign In");

  group("login page test", () {
    when(_repo.login("test@testmail.com", "password", context))
        .thenAnswer((_) async => true);
    testWidgets('email, password and button are found',
        (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestable(const LoginPage()));
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(signInButton, findsOneWidget);
    });
    testWidgets("validates empty email and password",
        (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestable(const LoginPage()));
      await tester.tap(signInButton);
      await tester.pump();
      expect(find.text("Digite seu e-mail"), findsOneWidget);
      expect(find.text("Digite sua senha"), findsOneWidget);
    });

    testWidgets("calls sign in method when email and password is entered",
        (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestable(const LoginPage()));
      await tester.enterText(emailField, "test@testmail.com");
      await tester.enterText(passwordField, "password");
      await tester.tap(signInButton);
      await tester.pump();
      verify(_repo.login("test@testmail.com", "password", context)).called(1);
    });
  });
}
