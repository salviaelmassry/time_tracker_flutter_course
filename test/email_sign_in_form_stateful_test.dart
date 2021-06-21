import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}
class MockUser extends Mock implements User {}
void main() {
  MockAuth mockAuth;

  // setUp will run everytime we run a test
  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester,
      {VoidCallback onSignedIn}) async {
    await tester.pumpWidget(Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: ScreenUtilInit(
            designSize: Size(279, 565),
            allowFontScaling: true,
            builder: () => Scaffold(
              body: EmailSignInFormStateful(
                onSignedIn: onSignedIn,
              ),
            ),
          ),
        )));
  }

  void stubSignInWithEmailAndPasswordSucceeds(){
    when(mockAuth.signInWithEmailAndPassword(any, any)).thenAnswer((_) => Future<User>.value(MockUser()));
  }
  void stubSignInWithEmailAndPasswordThrows(){
    when(mockAuth.signInWithEmailAndPassword(any, any)).thenThrow(FirebaseAuthException(code :'wrong credentials'));
  }
  group('sign in', () {
    testWidgets(
        'GIVEN user is on the email sign in page '
        'WHEN user doesn\'t enter the email and password '
        'AND user taps on the sign-in button '
        'THEN signInWithEmailAndPassword is not called'
        'AND user is not signed-in', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);
      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      //then signInWithEmailAndPassword is not called
      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });
    testWidgets(
        'GIVEN user open the email sign in page '
        'WHEN user enters valid email and password '
        'AND user taps on the sign-in button '
        'THEN signInWithEmailAndPassword is called'
        'AND user is signed-in', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);
      stubSignInWithEmailAndPasswordSucceeds();
      const email = 'email@email.com';
      const password = 'password';

      //get textField widget by using its key
      // make sure that we can find this widget
      // add the text to the textField widget
      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      // same for the password field
      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      //pump() triggers a widget rebuild
      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      //.called(1) ---> how many times should this method be called
      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, true);
    });
    testWidgets(
        'GIVEN user open the email sign in page '
            'WHEN user enters invalid email and password '
            'AND user taps on the sign-in button '
            'THEN signInWithEmailAndPassword is called'
            'AND user is  not signed-in', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);
      stubSignInWithEmailAndPasswordThrows();
      const email = 'email@email.com';
      const password = 'password';

      //get textField widget by using its key
      // make sure that we can find this widget
      // add the text to the textField widget
      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      // same for the password field
      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      //pump() triggers a widget rebuild
      await tester.pump();

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      //.called(1) ---> how many times should this method be called
      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, false);
    });
  });

  group('register', () {
    testWidgets(
        'GIVEN user opens the email sign in page '
        'WHEN user taps on the secondary button '
        'THEN form toggles to registration mode', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets(
        'GIVEN user opens the email sign in page '
        'WHEN user taps on the secondary button '
        'AND user enters the email and password '
        'THEN createUserWithEmailAndPassword is called',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'email@email.com';
      const password = 'password';

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      //get textField widget by using its key
      // make sure that we can find this widget
      // add the text to the textField widget
      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      // same for the password field
      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      //pump() triggers a widget rebuild
      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);

      await tester.tap(createAccountButton);

      //.called(1) ---> how many times should this method be called
      verify(mockAuth.createUserWithEmailAndPassword(email, password))
          .called(1);
    });
  });
}
