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
      home: Exercise3(),
    );
  }
}

class Exercise3 extends StatelessWidget {
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
          'Kegel',
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
          children: <Widget>[
            SizedBox(height: 5),

            Center(
              child: Text(
                'บริหารกล้ามเนื้ออุ้งเชิงกราน',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            // รูปภาพในรูปสี่เหลี่ยมพร้อมขอบโค้งมน
            Container(
              width: 300.0, // กำหนดความกว้าง
              height: 200.0, // กำหนดความสูง
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/image/Ex3.webp'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0), // เพิ่มขอบโค้งมน
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
                        '• ขมิบ หรือกลั้นปัสสาวะ\n'
                            '• ทำครั้งละ 5-10 วินาที แล้วคลายลง\n'
                            '• ทำสลับกันเรื่อยๆ\n'
                            '• ทำอย่างน้อย 45-50 ครั้ง/วัน \n'
                            '• แบ่งเป็น Set ย่อยๆได้ \n'
                            '• ทำ 15 ครั้ง/Set ทั้งหมด 3 Set\n',
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
                _launchURL(context, 'https://youtu.be/2JT8YOK0NjA?si=QzVq1th9Dn6KieGh'); // URL ของ YouTube
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

