import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/Register2.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/manu1.dart';
import 'package:projectlasttt/manu31.dart';
import 'package:projectlasttt/manu32.dart';
import 'package:projectlasttt/manu33.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu7.dart';
import 'package:projectlasttt/Group1.dart';
import 'package:projectlasttt/Group2.dart';
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
      home: Group1(),
    );
  }
}

class Group1 extends StatefulWidget {
  @override
  _Group1State createState() => _Group1State();
}

class _Group1State extends State<Group1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'อาการและท่าออกกำลังกาย',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // เพิ่มตัวหนาที่นี่
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // เปลี่ยนเป็น start
          children: <Widget>[
            SizedBox(height: 20), // ช่องว่างด้านบน
            MenuButton(
              icon: 'assets/image/011.png',
              label: 'อาการและข้อควรปฏิบัติ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manu3()),
                );
              },
            ),
            SizedBox(height: 10),
            MenuButton(
              icon: 'assets/image/022.png',
              label: 'ท่าออกกำลังกาย',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manu4()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  MenuButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Full width button
        padding: EdgeInsets.all(16.0), // Adjust padding as needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(icon, width: 105, height: 105), // Adjust width and height
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
