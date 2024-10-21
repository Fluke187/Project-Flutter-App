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
      home: Exercise5(),
    );
  }
}

class Exercise5 extends StatelessWidget {
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
          'Pelvic tilt',
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
                ' เพิ่มความแข็งแรง\nของกล้ามเนื้อแกนกลางลำตัว',
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
                  image: AssetImage('assets/image/Ex5.webp'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
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
                        '• นอนหงายบนเสื่อโยคะ \n'
                            '• ชันเข่าทั้ง 2 ข้างขึ้น\n'
                            '• เอามือทั้ง 2 ข้างวางไว้ข้างลำตัว\n'
                            '• เกร็งหน้าท้อง\n'
                            '• ฝึกหายใจเข้าทางจมูก ให้ท้องป่อง \n'
                            '• หายใจออกทางปาก ให้ท้องแฟบ \n'
                            '• หายใจพร้อมเกร็งกล้ามเนื้อลำตัว \n'
                            '• เริ่มจากหายใจเข้าทางจมูก แอ่นตัวขึ้น \n'
                            '• ค้างไว้ 1-2 วินาที\n'
                            '• เมื่อหายใจออกทางปาก ให้เกร็งหน้าท้อง \n'
                            '• แล้วลงไปนอนท่าเดิม กดหลังให้ติดพื้น \n'
                            '• ทำซ้ำกัน 3-5 ครั้ง \n',
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
                _launchURL(context, 'https://youtu.be/aRqF0B6bj8o?si=7nXdJQeMDTy-dFj4'); // URL ของ YouTube
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
