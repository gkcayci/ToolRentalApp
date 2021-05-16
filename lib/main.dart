import 'package:flutter/material.dart';

//my own imports
import 'package:firebase_core/firebase_core.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.deepOrange),
    home: Login(),
  ) //MaterialApp
      );
}
