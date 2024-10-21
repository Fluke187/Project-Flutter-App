import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/Register2.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/manu1.dart';
import 'package:projectlasttt/manu10.dart';
import 'package:projectlasttt/manu31.dart';
import 'package:projectlasttt/manu32.dart';
import 'package:projectlasttt/manu33.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu7.dart';
import 'package:projectlasttt/Group1.dart';
import 'package:projectlasttt/Group2.dart';
import 'package:projectlasttt/manu9.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manu.dart';
import 'manu3.dart';
import 'manu4.dart';
import 'manu8.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Group2(), // เรียกใช้ Group2 ได้อย่างถูกต้อง
    );
  }
}

class Group2 extends StatefulWidget {
  @override
  _Group2State createState() => _Group2State();
}

class _Group2State extends State<Group2> {
  Future<int> loadCheckupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");
    print("userId : $userId");

    if (userId == null) {
      print("ไม่พบ userId ใน SharedPreferences");
      return 0; // หรือค่าอื่นที่แสดงว่าไม่พบข้อมูล
    }

    final response = await http.post(
      Uri.parse(
          'http://thanadon.3bbddns.com:56600/Api/GetFoodbyUserId/GetFoodbyUserId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'uid': userId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final foods = data['foods'] as List<dynamic>;

      if (foods.isEmpty) {
        return 0; // หรือค่าอื่นที่แสดงว่าไม่พบข้อมูลอาหาร
      }

      int maxId = foods
          .map<int>((food) => food['id'] as int)
          .reduce((max, id) => id > max ? id : max);

      if (maxId >= 1 && maxId <= 6) {
        return 1; // ไตรมาสที่ 1
      } else if (maxId >= 7 && maxId <= 12) {
        return 2; // ไตรมาสที่ 2
      } else if (maxId >= 13 && maxId <= 18) {
        return 3; // ไตรมาสที่ 3
      } else {
        return 0; // หรือค่าอื่นที่แสดงว่า id ไม่อยู่ในช่วงที่กำหนด
      }
    } else {
      print("เกิดข้อผิดพลาดในการเรียก API: ${response.statusCode}");
      return 0; // หรือค่าอื่นที่แสดงว่าเกิดข้อผิดพลาด
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'อาหาร',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // เพิ่มตัวหนาที่นี่
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // เปลี่ยนเป็น start เพื่อให้ปุ่มอยู่ด้านบน
          children: <Widget>[
            SizedBox(height: 20), // เพิ่มช่องว่างจากด้านบน
            MenuButton(
              icon: 'assets/image/033.png',
              label: 'อาหารที่ควรรับประทาน',
              onTap: () async {
                int trimester = await loadCheckupData();

                switch (trimester) {
                  case 1:
                    print("อยู่ในไตรมาสที่ 1 (สัปดาห์ 1-3)");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Manu6()),
                    );
                    break;
                  case 2:
                    print("อยู่ในไตรมาสที่ 2 (สัปดาห์ 4-6)");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Manu9()),
                    );
                    break;
                  case 3:
                    print("อยู่ในไตรมาสที่ 3 (สัปดาห์ 7-9)");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Manu10()),
                    );
                    break;
                  case 0:
                    print("ไม่พบข้อมูลสัปดาห์ หรือสัปดาห์ไม่อยู่ในช่วง 1-9");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Manu6()),
                    );
                    break;
                }
              },
            ),
            SizedBox(height: 10),
            MenuButton(
              icon: 'assets/image/044.png',
              label: 'อาหารที่ควรหลีกเลี่ยง',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Manu7()), // นำไปที่ Manu7
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  MenuButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // ปุ่มเต็มความกว้าง
        padding: EdgeInsets.all(16.0), // ปรับระยะห่างภายในตามที่ต้องการ
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(icon, width: 105, height: 105), // ปรับขนาดไอคอน
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
