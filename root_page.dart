import 'package:flutter/material.dart';
import 'login/login_page.dart';
import 'auth.dart';
import 'halamanutama/front_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login/register_page.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn, createAccount }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn; //test
  initState() {
    //untuk mengecek user yang sedang login
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      authStatus = AuthStatus.notSignedIn;
    } else {
      authStatus = AuthStatus.signedIn;
    }
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  void moveToRegisterPage() {
    setState(() {
      authStatus = AuthStatus.createAccount;
    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    //widget build untuk mengaktifkan widget tree
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedIn:
        return FrontPage(
          auth: widget.auth,
          onSignedOut: _signedOut,
          createAccount: moveToRegisterPage,
        );

      case AuthStatus.createAccount:
        return RegisterPage(
          auth: widget.auth,
          mainPage: _signedIn,
        );
    }
  }
}
