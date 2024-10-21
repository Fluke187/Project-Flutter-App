import 'package:flutter/material.dart';
import 'package:projectlasttt/Register2.dart';

import 'Data/ApiService.dart';
import 'login.dart'; // นำเข้าหน้า Re2

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Re1(),
    );
  }
}

class Re1 extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAFAFA), // สีพื้นหลังอ่อน ๆ
      appBar: AppBar(
        backgroundColor: Color(0xFFDAFAFA), // สีของ AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // ไอคอนย้อนกลับ
          onPressed: () {
            Navigator.pop(context); // ย้อนกลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: SingleChildScrollView(
        // Make the body scrollable
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // ปรับให้ทุกอย่างอยู่ด้านบน
              crossAxisAlignment:
                  CrossAxisAlignment.center, // จัดให้อยู่กลางแนวนอน
              children: <Widget>[
                CircleAvatar(
                  radius: 110.0,
                  backgroundColor:
                      Colors.transparent, // ตั้งค่าให้พื้นหลังเป็นโปร่งใส
                  backgroundImage:
                      AssetImage('assets/image/0003.png'), // ใส่รูปภาพ icon
                ),
                SizedBox(height: 10.0),
                Text(
                  'สมัครสมาชิก',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10), // เพิ่มความห่างระหว่างหัวข้อและช่องกรอก
                _buildSizedTextField('ชื่อผู้ใช้งาน', usernameController),
                SizedBox(height: 10), // เพิ่มความห่างระหว่างช่องกรอก
                _buildSizedTextField('รหัสผ่าน', passwordController),
                SizedBox(height: 10), // เพิ่มความห่างระหว่างช่องกรอก
                _buildSizedTextField('Email', emailController),
                SizedBox(height: 20), // เพิ่มความห่างก่อนปุ่ม
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Re2(Username:usernameController.value.text,Password:passwordController.value.text,Email:emailController.value.text,)),
                    );
                    // var Register = await ApiService().register(
                    //   usernameController.value.text,
                    //   passwordController.value.text,
                    //   emailController.value.text,
                    // );
                    // if (Register != null && Register.isSuccess == true) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => Re2()),
                    //   );
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text('ไม่สามารถเพิ่มเข้าระบบได้'),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    // }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'ถัดไป',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white), // เปลี่ยนสีข้อความที่นี่
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent, // สีของปุ่ม
                  ),
                ),
                SizedBox(height: 20), // เพิ่มความห่างใต้ปุ่ม
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้าง TextField พร้อมกำหนดขนาด
  Widget _buildSizedTextField(String label, TextEditingController controller) {
    return SizedBox(
      width: 300, // กำหนดความกว้างของ TextField
      height: 46, // กำหนดความสูงของ TextField
      child: TextField(
        controller: controller, // ตั้งค่าตัวควบคุมสำหรับแต่ละ TextField
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(25.0), // กำหนดความโค้งมนที่ต้องการ
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 20.0), // ปรับขนาด padding ภายใน
        ),
      ),
    );
  }

  // ฟังก์ชันตรวจสอบข้อมูลและนำไปหน้าถัดไป
  void _validateAndNavigate(BuildContext context) {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text.isEmpty) {
      // ถ้าข้อมูลไม่ครบ ให้แสดงข้อความแจ้งเตือน
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('ข้อมูลไม่ครบถ้วน'),
          content: Text('กรุณากรอกข้อมูลให้ครบทุกช่อง'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    } else {
      // ถ้าข้อมูลครบ นำทางไปหน้าถัดไป
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Re2()),
      );
    }
  }
}
