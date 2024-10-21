import 'package:flutter/material.dart';
import 'package:projectlasttt/manu31.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thalassemia Symptoms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Manu33(),
    );
  }
}

class Manu33 extends StatefulWidget {
  @override
  _Manu33State createState() => _Manu33State();
}

class _Manu33State extends State<Manu33> {
  int _selectedIndex = 1; // Default to Home tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add your navigation logic here if needed
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
          'โรคธาลัสซีเมีย',
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
                  radius: 60,
                  backgroundImage: AssetImage('assets/image/T33.jpg'),
                ),
                SizedBox(height: 16),
                Text(
                  'โรคธาลัสซีเมีย',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                  textAlign: TextAlign.center, // Center the text
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
                          '• มีอาการของภาวะโลหิตจางอันได้แก่ ซีด เหนื่อยง่ายเวลาออกแรง มีผิวสีระ หนังซีดเป็นลมบ่อย\n'
                              '• มีการขยายตัวของกระดูกหน้าผากและกรามบนทำให้ใบหน้าบาน กระโหลกศีรษะหนาที่เรียกว่า thalassemia facies\n'
                              '• การเจริญเติบโตไม่สมวัย\n'
                              '• ถ้าสำรวจพบฮีโมโกลบินแย่มาก เช่น Hb Bart hydrops fetalis จะมีความผิดปกติตั้งแต่เกิดจนถึงเสียชีวิตได้ในที่สุด\n'
                              '• อาการบวมที่ขา\n'
                              '• ท้องโตจากตับโตม้ามโต\n'
                              '• ร่างกายเติบโตไม่สมวัย',
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
