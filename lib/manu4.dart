import 'package:flutter/material.dart';
import 'package:projectlasttt/Exercise1.dart';
import 'package:projectlasttt/Exercise2.dart';
import 'package:projectlasttt/Exercise3.dart';
import 'package:projectlasttt/Exercise4.dart';
import 'package:projectlasttt/Exercise5.dart';
import 'package:projectlasttt/Exercise6.dart';
import 'package:projectlasttt/Exercise7.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu4(),
    );
  }
}

class Manu4 extends StatefulWidget {
  @override
  _Manu4State createState() => _Manu4State();
}

class _Manu4State extends State<Manu4> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    NotificationPage(), // Notification screen
    HomeScreen(), // Main menu screen
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA), // สีพื้นหลังอ่อน ๆ
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ท่าออกกำลังกาย',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // ทำให้ตัวหนา
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: <Widget>[
              MenuButton(
                icon: 'assets/image/N001.png',
                label: 'บริหารกล้ามเนื้อต้นขา',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise1()),
                  );
                },
              ),
              MenuButton(
                icon: 'assets/image/N002.png',
                label: 'บริหารกล้ามเนื้อหลัง',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise2()),
                  );
                },
              ),
              MenuButton(
                icon: 'assets/image/N003.png',
                label: 'เพิ่มความแข็งแรงของกล้ามเนื้อ',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise3()),
                  );
                },
              ),
              MenuButton(
                icon: 'assets/image/N004.png',
                label: 'บริหารกล้ามเนื้ออุ้งเชิงกราน',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise4()),
                  );
                },
              ),
              MenuButton(
                icon: 'assets/image/N005.png',
                label: 'เพิ่มความแข็งแรงของกล้ามเนื้อกลางลำตัว',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise5()),
                  );
                },
              ),
              MenuButton(
                icon: 'assets/image/N006.png',
                label: 'เพิ่มกล้ามเนื้อและความแข็งแรงของช่วงล่าง',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise6()),
                  );
                },
              ),
              MenuButton(
                icon: 'assets/image/N007.png',
                label: 'บริหารกล้ามเนื้อบริเวณรอบแนวกระดูกสันหลัง',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Exercise7()),
                  );
                },
              ),
            ],
          ),
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(icon, width: 70, height: 70), // Adjusted width and height
            SizedBox(height: 5.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black), // Increased font size
            ),
          ],
        ),
      ),
    );
  }
}
