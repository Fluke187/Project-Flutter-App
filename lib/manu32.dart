import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Symptoms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Manu32(),
    );
  }
}

class Manu32 extends StatefulWidget {
  @override
  _Manu32State createState() => _Manu32State();
}

class _Manu32State extends State<Manu32> {
  int _selectedIndex = 1; // Default to Home tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
        // Handle Notifications navigation if needed
        // Navigator.pushNamed(context, '/notifications'); // Define route if needed
          break;
        case 1:
        // Handle Home navigation if needed
        // Navigator.pushNamed(context, '/home'); // Define route if needed
          break;
        case 2:
        // Handle Profile navigation if needed
        // Navigator.pushNamed(context, '/profile'); // Define route if needed
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'อาการครรภ์เป็นพิษ', // เปลี่ยนเป็น "อาการครรภ์เป็นพิษ"
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold, // ทำให้ตัวอักษรหนา
          ),
          textAlign: TextAlign.center, // จัดให้อยู่ตรงกลาง
        ),
        backgroundColor: Color(0xFFDAFAFA),
      ),
      body: Container(
        color: Color(0xFFDAFAFA), // Set the background color here
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent, // ตั้งค่าให้พื้นหลังเป็นโปร่งใส
                  backgroundImage: AssetImage('assets/image/T32.png'),
                ),
                SizedBox(height: 16),
                Text(
                  'อาการครรภ์เป็นพิษ', // เปลี่ยนเป็น "อาการครรภ์เป็นพิษ"
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, // ทำให้ตัวอักษรหนา
                  ),
                  textAlign: TextAlign.center, // จัดให้อยู่ตรงกลาง
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• บวม โดยเฉพาะบริเวณมือ เท้า หน้า\n'
                              '• ปวดศีรษะมาก\n'
                              '• ทารกดิ้นน้อย ตัวเล็ก โตช้า\n'
                              '• ความดันโลหิตสูง\n'
                              '• ตรวจพบโปรตีนในปัสสาวะ\n'
                              '• ตาพร่ามัว \n'
                              '• ปวดหรือจุกเสียดแน่นบริเวณใต้ลิ้นปี่หรือชายโครงขวา\n',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
