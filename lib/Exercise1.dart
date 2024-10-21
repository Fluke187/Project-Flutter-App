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
      home: Exercise1(),
    );
  }
}

class Exercise1 extends StatelessWidget {
  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
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
          'Side Lunge',
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
                'บริหารกล้ามเนื้อต้นขา',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300.0, // กำหนดความกว้าง
              height: 200.0, // กำหนดความสูง
              decoration: BoxDecoration(
                color: Colors.transparent, // พื้นหลังโปร่งใส
                image: DecorationImage(
                  image: AssetImage('assets/image/Ex1.jpg'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
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
                        '• ยืดตัวตรง เปิดหลังให้ตรง\n'
                            '• เหยียดขาซ้ายไปด้านข้าง\n'
                            '• แอ่นก้น และขาขวาย่อลง\n'
                            '• ปลายเท้าซี้ตรง\n'
                            '• ทำสลับซ้าย และขวา นับเป็น 1 ครั้ง\n'
                            '• ทำประมาณ 15 ครั้ง/Set ทั้งหมด 3 Set\n',
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
                _launchURL(context, 'https://youtu.be/VLDkcHopP50');
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
