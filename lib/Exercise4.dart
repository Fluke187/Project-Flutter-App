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
      home: Exercise4(),
    );
  }
}

class Exercise4 extends StatelessWidget {
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
          'Tailor Sitting',
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
                'บริหารกล้ามเนื้ออุ้งเชิงกราน\nและกล้ามเนื้อหลัง',
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
                  image: AssetImage('assets/image/Ex4.webp'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
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
                        '• นั่งบนพื้น หรือเสื่อโยคะ \n'
                            '• ซึ่งคุณแม่มือใหม่อาจหาเบาะ\n'
                            '• หรือผ้าขนหนูมาใช้รองนั่งเสริม\n'
                            '• นั่งลง และแยกขาออกจากกัน\n'
                            '• ใช้มือดึงฝ่าเท้าทั้ง 2 ข้างเข้ามาประกบกัน \n'
                            '• โน้มตัวมาข้างหน้าเล็กน้อย \n'
                            '• อาจนั่งพิงกับกำแพง เพื่อช่วยให้หลังตรง \n'
                            '• ทำครั้งละ 5 วินาที \n'
                            '• แล้วค่อยๆ คลายออก ทำซ้ำกัน 5-10 ครั้ง\n',
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
                _launchURL(context, 'https://youtu.be/4zGz8VgPb8k?si=2-xpLCVu398L0l-y'); // URL ของ YouTube
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
