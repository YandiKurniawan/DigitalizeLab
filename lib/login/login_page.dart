import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_register/login/background.dart';
import '../auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  LoginPage({this.auth, this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _error;
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      //untuk tulisan pada email dan pass ketika tidak diisi
      form.save(); //maka akan menampilkan pesan yang ada pada validator
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (validateAndSave()) {
      try {
        String userId =
            await widget.auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in: $userId");
        widget.onSignedIn();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _error = 'Tidak ada User';
          return null;
        } else if (e.code == 'wrong-password') {
          _error = 'Password Salah';
          return null;
        } else if (e.code == 'invalid-email') {
          _error = 'Email Salah';
        }
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Background(),
          Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                      child: Text(
                        'Laboratory',
                        style: GoogleFonts.dancingScript(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: buildInputs() + buildSubmitButtons(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[600].withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value.isEmpty ? 'Tidak boleh Kosong' : null,
            onSaved: (value) => _email = value,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[600].withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              hintText: 'Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.security,
                  color: Colors.blue,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            obscureText: true,
            validator: (value) =>
                value.isEmpty ? "Password tidak boleh kosong" : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextButton(
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            onPressed: validateAndSubmit,
          ),
        ),
      )
    ];
  }
}
