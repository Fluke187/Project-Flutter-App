import 'package:flutter/material.dart';
import 'package:projectlasttt/HList.dart';
import 'package:projectlasttt/ListNoti.dart';
import 'package:projectlasttt/No01.dart';
import 'package:projectlasttt/addPrenancy.dart';
import 'list.dart';
import 'login.dart';
import 'manu.dart';
import 'package:projectlasttt/main.dart';
import 'package:projectlasttt/Register2.dart';
import 'package:projectlasttt/manu31.dart';
import 'package:projectlasttt/manu32.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[
    liset(), // Notification screen
    menumainstate(), // Main menu screen
    LoginScreen(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Records',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecordPage(),
    );
  }
}

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  int _selectedIndex = 1; // Default to Home tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.pushNamed(context, '/notifications'); // Define this route in MyApp
          break;
        case 1:
        // Already on Home
          break;
        case 2:
          Navigator.pushNamed(context, '/profile'); // Define this route in MyApp
          break;
      }
    });
  }

  void _addPregnancyRecord() {
    // Navigate to the Re2 screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPrenancy()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA), // Light background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('ประวัติการตั้งครรภ์', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text('การตั้งครรภ์รอบที่ 1'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => No01()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addPregnancyRecord,
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.blue,
      //   tooltip: 'เพิ่มการตั้งครรภ์',
      // ),
    );
  }
}
