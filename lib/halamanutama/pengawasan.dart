import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_register/halamanutama/detail-pengawasan.dart';
// import 'package:firebase_core/firebase_core.dart';

class Pengawasan extends StatefulWidget {
  @override
  _PengawasanState createState() => _PengawasanState();
}

class _PengawasanState extends State<Pengawasan> {
  final dbRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: dbRef.child('Status').onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return DetailPengawasan(snapshot.data.snapshot.value);
          } else {
            return Container(
              child: Text('tes'),
            );
          }
        },
      ),
    );
  }
}
