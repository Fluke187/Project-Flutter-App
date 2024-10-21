import 'package:flutter/material.dart';
import 'package:projectlasttt/manu31.dart';

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
      home: Manu31(),
    );
  }
}

class Manu31 extends StatefulWidget {
  @override
  _Manu31State createState() => _Manu31State();
}

class _Manu31State extends State<Manu31> {
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
          'อาการแพ้ท้อง',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold, // เพิ่มตัวหนาที่นี่
          ),
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
                  backgroundImage: AssetImage('assets/image/T31.png'),
                ),
                SizedBox(height: 16),
                Text(
                  'อาการแพ้ท้อง',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
                          '• คลื่นไส้ อาเจียน\n'
                              '• เวียนศีรษะ\n'
                              '• ท้องอืดเหมือนอาหารไม่ย่อย\n'
                              '• อ่อนเพลีย\n'
                              '• หน้ามืด \n'
                              '• เรอเปรี้ยว\n'
                              '• จุกแน่นลิ้นปี่\n'
                              '• ไวต่อกลิ่นต่าง ๆ\n'
                              '• หงุดหงิดง่าย\n',
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
