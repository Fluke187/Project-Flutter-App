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
      home: Manu3(),
    );
  }
}

class Manu3 extends StatefulWidget {
  @override
  _Manu3State createState() => _Manu3State();
}

class _Manu3State extends State<Manu3> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    NotificationPage(), // Notification screen
    Menumain(), // Main menu screen
    Account(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // ลบแถบเมนูด้านล่างออก
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Image.asset('assets/image/Warn.png', width: 40, height: 40),
      //       label: 'แจ้งเตือน',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset('assets/image/Home.png', width: 40, height: 40),
      //       label: 'หน้าหลัก',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset('assets/image/Profile.png', width: 40, height: 40),
      //       label: 'โปรไฟล์',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.lightBlue,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
class Menumain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ปรับข้อความให้อยู่ตรงกลางและเป็นตัวหนา
        title: Text(
          'อาการและข้อควรปฏิบัติ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // ทำให้ตัวอักษรเป็นตัวหนา
            fontSize: 20.0, // สามารถปรับขนาดตัวอักษรได้ตามต้องการ
          ),
          textAlign: TextAlign.center, // จัดให้อยู่ตรงกลาง
        ),
        centerTitle: true, // จัดให้ title อยู่ตรงกลางใน AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton(
              icon: 'assets/image/Manu31.png',
              label: 'อาการแพ้ท้อง',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manu31()),
                );
              },
            ),
            SizedBox(height: 10.0),
            MenuButton(
              icon: 'assets/image/Manu32.png',
              label: 'อาการครรภ์เป็นพิษ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manu32()),
                );
              },
            ),
            SizedBox(height: 10.0),
            MenuButton(
              icon: 'assets/image/Manu33.png',
              label: 'โรคธาลัสซีเมีย',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manu33()),
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
