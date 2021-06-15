import 'package:flutter/material.dart';
import 'package:login_register/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_register/models/constant.dart';
import 'auth.dart';
import 'root_page.dart';
import 'models/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'I-Lab Electronics Engineering',
        theme: ThemeData(
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: kTextColor)),
        home: RootPage(auth: Auth()));
  }
}
