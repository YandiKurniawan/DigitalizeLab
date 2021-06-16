import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:login_register/pinjaman/pinjaman.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final BaseAuth auth;
  RegisterPage({this.auth, this.mainPage});
  final VoidCallback mainPage;

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

enum FormType { login, register }
enum PageStatus { mainPage, createAccount }

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String newPassword;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
    var user;
    if (validateAndSave()) {
      try {
        // String userId =
        //     await widget.auth.createUserWithEmailAndPassword(email, password);
        // print("Create: $userId");
        user = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        print("Error: $e");
      }
    }
    formKey.currentState.reset();
    return user.user.uid;
  }

  void moveToFrontPage() {
    formKey.currentState.reset();
    setState(
      () {
        widget.mainPage();
      },
    );
  }

  // void tes(String tes) {
  //   Pinjaman(passdb: tes);
  // }

  void changePass() async {
    DocumentReference docPassword =
        firestore.collection("Password").doc('Password');
    docPassword.set(
      {'Password': newPassword},
    );
    formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('Password').snapshots(),
          // ignore: missing_return
          builder: (xtc, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: snapshot.data.docs.map(
                  (e) {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: buildInputs() +
                            buildSubmitButtons() +
                            gantiPassword(e.data()['Password']),
                      ),
                    );
                  },
                ).toList(),
              );
            } else {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> gantiPassword(String passwordDatabase) {
    return [
      TextFormField(
        decoration:
            InputDecoration(labelText: "Ganti Password ($passwordDatabase)"),
        obscureText: false,
        onChanged: (value) {
          setState(() {
            newPassword = value;
            // tes(passwordDatabase);
          });
        },
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          child: Text(
            "Ganti Password",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: changePass,
        ),
      ),
    ];
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: "Email"),
        validator: (value) => value.isEmpty ? "Email tidak boleh kosong" : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Password"),
        obscureText: false,
        validator: (value) =>
            value.isEmpty ? "Password tidak boleh kosong" : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          child: Text(
            "Buat Akun",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: validateAndSubmit,
        ),
      ),
    ];
  }
}
