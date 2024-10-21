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
      home: Exercise6(),
    );
  }
}

class Exercise6 extends StatelessWidget {
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
          ' Squatting',
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
          crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
          children: <Widget>[
            SizedBox(height: 5),
            Center(
              child: Text(
                'เพิ่มกล้ามเนื้อและ\n'
                    'ความแข็งแรงของช่วงล่าง',
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
                  image: AssetImage('assets/image/Ex6.webp'), // เปลี่ยน path ตามรูปภาพที่คุณใช้
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
                        '• กางขาทั้ง 2 ข้าง\n'
                            '• ให้มีระยะห่างเท่ากับช่วงไหล่\n'
                            '• ยืนหลังเก้าอี้ที่มีพนักพิง\n'
                            '• เพื่อให้หลังเกาะพนักเอาไว้\n'
                            '• ค่อยๆ ย่อเข่าลง เหมือนกำลังจะนั่งเก้าอี้ \n'
                            '• ระวังไม่ให้เข่าเลยปลายเท้า\n'
                            '• ทำค้างประมาณ 5 วินาที\n'
                            '• ทำทั้งหมด 10 ครั้ง\n',
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
                _launchURL(context, 'https://youtu.be/nPNNAxafo08?si=Auc1P6Giie74mfAH'); // URL ของ YouTube
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
