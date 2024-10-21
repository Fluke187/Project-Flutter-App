import 'package:flutter/material.dart';
import 'package:projectlasttt/AddLiset.dart';
import 'package:projectlasttt/Register2.dart';
import 'package:projectlasttt/list.dart';
import 'package:projectlasttt/manu1.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu7.dart';
import 'manu.dart';
import 'manu3.dart';
import 'manu4.dart';
import 'manu8.dart';
import 'manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: No01(),
    );
  }
}

class No01 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<No01> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    Text('แจ้งเตือน'), // Placeholder for notifications screen
    Menumain(), // Main menu screen
    Text('โปรไฟล์'), // Placeholder for profile screen
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/Warn.png', width: 40, height: 40),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/Home.png', width: 40, height: 40),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/Profile.png', width: 40, height: 40),
            label: 'โปรไฟล์',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
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
        title: Text('การตั้งครรภ์ครรภ์รอบที่ 1', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // First button to show pregnancy checkup data
            MenuButton(
              icon: 'assets/image/055.png',
              label: 'แสดงข้อมูลการตรวจครรภ์',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addliset()),
                );
              },
            ),
            SizedBox(height: 10.0),

            // Second button to show doctor appointment data
            MenuButton(
              icon: 'assets/image/077.png',
              label: 'แสดงข้อมูลนัดพบแพทย์',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => liset()),
                );
              },
            ),
            SizedBox(height: 10.0),
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
          borderRadius: BorderRadius.circular(10.0),
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
