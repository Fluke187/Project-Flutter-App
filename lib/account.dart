import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/login.dart';
import 'package:projectlasttt/manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Account(),
      routes: {
        '/notification': (context) => NotificationPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int _selectedIndex = 2; // Default to Profile tab

  static List<Widget> _widgetOptions = <Widget>[
    NotificationPage(), // Notification screen
    menumainstate(), // Main menu screen
    Account(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDAFAFA),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text(
          'Profile', // เพิ่มคำว่า Profile ที่นี่
          style: TextStyle(
            fontWeight: FontWeight.bold, // ทำให้ตัวหนา
            color: Colors.black, // สีของข้อความ
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFDAFAFA), // Set the background color here
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      InfoCard(icon: Icons.account_circle_outlined, text: 'ชื่อจริง - นามสกุล'),
                      SizedBox(height: 1), // Space between cards
                      InfoCard(icon: Icons.email, text: 'Email'),
                      SizedBox(height: 1), // Space between cards
                      InfoCard(icon: Icons.hail, text: 'ส่วนสูง'),
                      SizedBox(height: 1), // Space between cards
                      InfoCard(icon: Icons.monitor_weight, text: 'น้ำหนัก'),
                      // สามารถเพิ่มข้อมูลอื่น ๆ ได้ที่นี่ เช่น Email, Address, etc.
                    ],
                  ),
                ),
                SizedBox(height: 20), // Space before the button
                Center(
                  child: ElevatedButton(
                    onPressed: _logout,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      child: Text('ออกจากระบบ', style: TextStyle(
                        fontSize: 15.0, // Adjust font size
                        color: Colors.white, // Set text color to white
                      ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Set text color to white
                      backgroundColor: Colors.redAccent, // Set button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Rounded corners
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Added space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0), // Adjusted margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0), // Rounded corners
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 15.0, // Adjust font size
          ),
        ),
      ),
    );
  }
}
