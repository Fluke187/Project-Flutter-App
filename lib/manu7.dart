import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/Group2.dart';
import 'package:projectlasttt/manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu7(),
    );
  }
}

class Manu7 extends StatefulWidget {
  @override
  _Manu7State createState() => _Manu7State();
}

class _Manu7State extends State<Manu7> {
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
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAFAFA), // สีพื้นหลังที่กำหนด
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'อาหารที่ควรหลีกเลี่ยง',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // เพิ่มตัวหนา
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _buildFoodCard(context, 'ไข่ดิบ ไข่ที่ปรุงไม่สุก', 'assets/image/15.png',
                      'ไข่ดิบหรือไข่ที่ปรุงไม่สุกอาจทำให้ติดเชื้อแบคทีเรียซัลโมเนลล่า ซึ่งอันตรายต่อทั้งคุณแม่และลูกในครรภ์'),
                  _buildFoodCard(context, 'เนื้อ ปลาที่ปรุงไม่สุก', 'assets/image/16.png',
                      'เนื้อและปลาที่ปรุงไม่สุกอาจมีเชื้อโรคหรือปรสิตที่เป็นอันตรายต่อการตั้งครรภ์'),
                  _buildFoodCard(context, 'แอลกอฮอล์', 'assets/image/17.png',
                      'การบริโภคแอลกอฮอล์สามารถมีผลกระทบต่อพัฒนาการของทารกในครรภ์ได้'),
                  _buildFoodCard(context, 'อาหารสด เนื้อดิบ', 'assets/image/18.png',
                      'อาหารสดหรือเนื้อดิบอาจมีเชื้อโรคที่สามารถทำให้เกิดการติดเชื้อได้'),
                  _buildFoodCard(context, 'ของหมักดอง', 'assets/image/19.png',
                      'อาหารหมักดองอาจมีโซเดียมสูง และอาจไม่ดีต่อสุขภาพในระหว่างตั้งครรภ์'),
                  _buildFoodCard(context, 'อาหารเผ็ดจัด', 'assets/image/20.png',
                      'อาหารเผ็ดจัดอาจทำให้เกิดอาการไม่สบายท้องหรือกรดไหลย้อนได้'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, String title, String imagePath, String description) {
    return GestureDetector(
      onTap: () {
        _showFoodDetailsDialog(context, title, imagePath, description);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันเพื่อแสดงป๊อปอัพรายละเอียดอาหาร
  void _showFoodDetailsDialog(BuildContext context, String title, String imagePath, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDAFAFA), // เปลี่ยนสีพื้นหลัง
          title: Center( // ทำให้หัวข้ออยู่ตรงกลาง
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // ปรับขนาดอักษรของ title ที่นี่
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // ปรับขนาดของคอนเทนต์ให้เล็กที่สุด
            children: [
              Image.asset(imagePath, height: 100, fit: BoxFit.cover),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 16), // ปรับขนาดอักษรของ description ที่นี่
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิดป๊อปอัพ
              },
              child: Text('ปิด'),
            ),
          ],
        );
      },
    );
  }
}
