import 'package:flutter/material.dart';
import 'login.dart'; // หน้าที่จะนำทางไปหลังจากบันทึกรหัสผ่านสำเร็จ

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ซ่อนแถบ debug
      home: OTP2(),
    );
  }
}

class OTP2 extends StatefulWidget {
  @override
  _OTP2State createState() => _OTP2State();
}

class _OTP2State extends State<OTP2> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // ล้างข้อมูลใน TextEditingController เมื่อไม่ใช้งานแล้ว
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // ตรวจสอบว่าทั้งสองช่องไม่ว่าง
    if (password.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog("กรุณากรอกรหัสผ่านทั้งสองช่อง");
      return;
    }

    // ตรวจสอบว่ารหัสผ่านทั้งสองช่องตรงกัน
    if (password != confirmPassword) {
      _showErrorDialog("รหัสผ่านไม่ตรงกัน");
      return;
    }

    // หากรหัสผ่านทั้งสองช่องถูกต้อง นำทางไปยังหน้า LoginScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // ฟังก์ชันสำหรับแสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
  void _showErrorDialog(String message) {
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
          'ตั้งรหัสผ่านใหม่',
          style: TextStyle(
            fontWeight: FontWeight.bold, // ทำให้ตัวหนา
          ),
        ), // ชื่อของหน้า
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // ลูกศรย้อนกลับ
          onPressed: () {
            Navigator.pop(context); // ย้อนกลับไปยังหน้าก่อนหน้า
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
              SizedBox(height: 10),

              // ข้อความ "กรุณาระบุรหัสผ่านใหม่"
              Text(
                'กรุณาระบุรหัสผ่านใหม่',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),

              // ช่องกรอกรหัสผ่านใหม่
              Container(
                width: 350.0, // กำหนดความกว้างของช่องกรอก
                child: TextField(
                  controller: _passwordController,
                  obscureText: true, // ซ่อนข้อความรหัสผ่าน
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: 'กรอกรหัสผ่านใหม่',
                    filled: true,
                    fillColor: Colors.white, // สีของช่องกรอก
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // ปรับขนาดช่องกรอก
                  ),
                ),
              ),
              SizedBox(height: 20),

              // ช่องกรอกรหัสผ่านอีกครั้ง
              Container(
                width: 350.0, // กำหนดความกว้างของช่องกรอก
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true, // ซ่อนข้อความรหัสผ่าน
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: 'กรอกรหัสผ่านใหม่อีกครั้ง',
                    filled: true,
                    fillColor: Colors.white, // สีของช่องกรอก
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // ปรับขนาดช่องกรอก
                  ),
                ),
              ),
              SizedBox(height: 20),

              // ปุ่ม "บันทึก"
              ElevatedButton(
                onPressed: _savePassword, // เรียกใช้ฟังก์ชันเมื่อกดปุ่ม
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // สีของปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                ),
                child: Text(
                  'บันทึก',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54 // สีของข้อความในปุ่ม
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
