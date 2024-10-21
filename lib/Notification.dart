import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/manu1.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu7.dart';
import 'package:projectlasttt/record.dart';
import 'manu.dart';
import 'manu3.dart';
import 'manu4.dart';
import 'manu8.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDAFAFA), // Set the AppBar background color here
        title: Text(
          'แจ้งเตือน',
          style: TextStyle(color: Colors.black, fontSize: 25), // Set the font size to 25
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Add your back button functionality here
          },
        ),
      ),
      backgroundColor: Color(0xFFDAFAFA), // Set the background color of the Scaffold here
    );
  }

  Widget _buildNotificationCard(String date) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            date,
            style: TextStyle(fontSize: 18),
          ),
          Icon(Icons.circle, color: Colors.red, size: 10),
        ],
      ),
    );
  }
}
