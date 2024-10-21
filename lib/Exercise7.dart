import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Exercise7(),
    );
  }
}

class Exercise7 extends StatelessWidget {
  // ฟังก์ชันสำหรับเปิด URL ของ YouTube
  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url); // แปลง URL เป็น Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถเปิด $url ได้')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quadruped cat',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFDAFAFA),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFDAFAFA),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5),
            Center(
              child: Text(
                ' บริหารกล้ามเนื้อ\nบริเวณรอบแนวกระดูกสันหลัง',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),

            // รูปภาพในรูปสี่เหลี่ยมพร้อมขอบโค้งมน
            Container(
              width: 300.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/image/Ex7.webp'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),

            SizedBox(height: 10),
            Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ตั้งท่าเหมือนกำลังคลานเข่า\n'
                            '• เหยียดแขนตรง\n'
                            '• วางมือลงในตำแหน่งเท่ากับไหล่\n'
                            '• หายใจเข้า งอตัวให้สุด\n'
                            '• ก่งหลัง ก้มคอลง\n'
                            '• ทำค้างไว้ประมาณ 5 วินาที \n'
                            '• หายใจออกช้าๆ แล้วแอ่นหลัง\n'
                            '• ยกก้นพร้อมเงยหน้าขึ้น \n'
                            '• ทำค้างไว้ประมาณ 5 วินาที\n'
                            '• ทำซ้ำ 5-10 ครั้ง\n',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _launchURL(context, 'https://youtu.be/ULIx2RjP5g8?si=gbTdHJfMGFVNrn_3'); // URL ของ YouTube
              },
              icon: Icon(Icons.play_circle_fill),
              label: Text('ดูวิดีโอ YouTube'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

