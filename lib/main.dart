import 'package:flutter/material.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/Register2.dart';
import 'package:projectlasttt/manu31.dart';
import 'package:projectlasttt/manu4.dart';
import 'package:projectlasttt/manu8.dart';
import 'Register1.dart';
import 'account.dart';
import 'login.dart';
import 'manu.dart';
import 'manu1.dart';
import 'manu3.dart';
import 'manu32.dart';
import 'package:projectlasttt/OTP.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
