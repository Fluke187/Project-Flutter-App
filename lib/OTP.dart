import 'package:flutter/material.dart';
import 'package:projectlasttt/OTP1.dart';
import 'package:projectlasttt/OTP.dart';
import 'package:projectlasttt/OTP2.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // ฟังก์ชันสำหรับแสดง Dialog ข้อผิดพลาด
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ข้อผิดพลาด'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAFAFA), // สีพื้นหลังตามภาพที่ให้มา
      appBar: AppBar(
        title: Text(
          'ลืมรหัสผ่าน', // ชื่อหน้าจอ
          style: TextStyle(
            fontWeight: FontWeight.bold, // ทำให้ตัวหนา
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // ลูกศรย้อนกลับ
          onPressed: () {
            Navigator.of(context).pop(); // ย้อนกลับไปยังหน้าก่อนหน้า
          },
        ),
        backgroundColor: Color(0xFFDAFAFA), // สีพื้นหลังของ AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/image/0001.png'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
              ),
              SizedBox(height: 10.0),
              Text(
                'ป้อน Username และ Email ของคุณ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _usernameController,
                style: TextStyle(
                  fontSize: 15.0, // ปรับขนาดข้อความในช่องกรอก
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // ปรับขนาดช่องกรอก
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _phoneController,
                style: TextStyle(
                  fontSize: 15.0, // ปรับขนาดข้อความในช่องกรอก
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // ปรับขนาดช่องกรอก
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'คุณอาจได้รับทาง Email จากเรา \n'
                    'เพื่อวัตถุประสงค์ด้านความปลอดภัย',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // ตรวจสอบว่าช่องกรอก Username และ Email ถูกกรอกหรือไม่
                  if (_usernameController.text.isEmpty || _phoneController.text.isEmpty) {
                    // ถ้าไม่กรอก Username หรือ Email ให้แสดงข้อผิดพลาด
                    _showErrorDialog(context, "กรุณากรอก Username และ Email ของคุณ");
                  } else {
                    // ถ้ากรอกแล้วให้ไปยังหน้าถัดไป
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OTP2()),
                    );
                  }
                },
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: 15.0, // ปรับขนาดตัวอักษร
                    color: Colors.black54, // ปรับสีข้อความในปุ่ม
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent, // สีปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
