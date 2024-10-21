import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectlasttt/OTP1.dart';
import 'package:projectlasttt/OTP2.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: OTPScreen(),
  ));
}

class OTPScreen extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();

  // ฟังก์ชันสำหรับแสดงข้อความแจ้งเตือนเมื่อกรอก OTP ไม่ครบ
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
          'กรอกรหัส', // ชื่อหน้าจอ
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
        elevation: 0, // ไม่ให้มีเงาใต้ AppBar
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
                'Email',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 300.0, // กำหนดความกว้างของ TextField
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6, // กำหนดจำนวนหลัก OTP ที่รับได้
                  style: TextStyle(
                    fontSize: 15.0, // ปรับขนาดตัวอักษรในช่องกรอก
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // ปรับขนาดช่องกรอกข้อความ
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'กรุณากรอกเลขจาก Email จำนวน 6 หลัก',  // คำบรรยาย
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // ฟังก์ชันการทำงานเมื่อต้องการยืนยัน OTP
                  String otp = _otpController.text;

                  // ตรวจสอบว่าผู้ใช้กรอกครบ 6 หลักหรือไม่
                  if (otp.length == 6) {
                    print("OTP Entered: $otp");
                    // นำทางไปยังหน้า OTP2
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OTP2()),
                    );
                  } else {
                    // ถ้า OTP ไม่ครบ 6 หลัก แสดงข้อความแจ้งเตือน
                    _showErrorDialog(context, "กรุณากรอก OTP ให้ครบ 6 หลัก");
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
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
