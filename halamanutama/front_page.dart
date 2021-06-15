import 'package:flutter/material.dart';
import 'package:login_register/components/body.dart';
import 'package:login_register/halamanutama/pengawasan.dart';
import 'package:login_register/pinjaman/pinjaman.dart';
import 'package:login_register/login/register_page.dart';
import '../auth.dart';
import 'package:flutter/widgets.dart';
import '../database/database.dart';

class FrontPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback createAccount;
  FrontPage({this.auth, this.onSignedOut, this.createAccount});

  @override
  State<StatefulWidget> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    Body(),
    Pinjaman(),
    Database(),
    RegisterPage(),
    Pengawasan()
  ];

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  // void _createAccount() {
  //   widget.createAccount();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Color(0xFF0C9869),
              icon: Icon(Icons.home),
              label: "Laboratorium"),
          BottomNavigationBarItem(
              icon: Icon(Icons.attachment_rounded), label: "Pinjaman"),
          BottomNavigationBarItem(
              icon: Icon(Icons.data_usage), label: "Database"),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: "Buat Akun"),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye_outlined), label: "RealTime Lab")
        ],
        currentIndex: selectedIndex,
        onTap: onItemTap,
        fixedColor: Colors.blue,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF0C9869),
      elevation: 0,
      actions: [
        TextButton(
          onPressed: _signOut,
          child: Text("Logout",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}
