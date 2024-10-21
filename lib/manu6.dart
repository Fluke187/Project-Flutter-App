import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu9.dart';
import 'package:projectlasttt/manu10.dart';
import 'package:projectlasttt/Group2.dart';
import 'package:projectlasttt/manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu6(),
    );
  }
}

class Manu6 extends StatefulWidget {
  @override
  _Manu6State createState() => _Manu6State();
}

class _Manu6State extends State<Manu6> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    NotificationPage(), // Notification screen
    HomeScreen(), // Main menu screen
    Account(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAFAFA), // สีพื้นหลังที่กำหนด
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'อาหารที่เหมาะสม',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // เพิ่มตัวหนา
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'ช่วง 1 - 3 เดือน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _buildFoodCard(context, 'โจ๊กข้าวกล้อง', 'assets/image/1.png',
                      'ช่วยให้คุณแม่รับประทานได้ง่าย ข้าวกล้องช่วยบรรเทาอาการอ่อนเพลีย ปวดกล้ามเนื้อได้ รวมถึงในข้าวกล้องมีแคลเซียม ธาตุเหล็กอยู่มาก จึงช่วยบำรุงคุณแม่ให้แข็งแรง และมีฟอสฟอรัสช่วยให้กระดูก ฟัน และเส้นผมของลูกน้อยเติบโต'),
                  _buildFoodCard(
                      context,
                      'บรอกโคลีผัดกุ้ง',
                      'assets/image/2.png',
                      'อุดมไปด้วยโฟเลตและวิตามินซีจากบรอกโคลี ซึ่งมีส่วนช่วยให้รกแข็งแรง ช่วยในการดูดซึมธาตุเหล็กได้ดียิ่งขึ้น และช่วยสร้างภูมิต้านทานโรคให้กับลูกน้อย ส่วนกุ้งมีทั้งโปรตีนและไอโอดีนมีส่วนช่วยเรื่องการพัฒนาด้านสมองและสติปัญญาของลูกน้อยในครรภ์'),
                  _buildFoodCard(context, 'ซุปผักโขม', 'assets/image/3.png',
                      'อุดมด้วยธาตุเหล็กและไอโอดีนจากผักโขม ช่วยให้เซลล์เม็ดเลือดแดงนำออกซิเจนไปเลี้ยงส่วนต่าง ๆ ของร่างกายของแม่และลูกน้อยในครรภ์ พร้อมพัฒนาระบบประสาทของลูกน้อย'),
                  _buildFoodCard(
                      context,
                      'ปลากะพงนึ่งมะนาว',
                      'assets/image/4.png',
                      'ช่วยบำรุงกระดูก อีกทั้งมีวิตามินและแร่ธาตุที่ดีจากปลากะพง วัตถุดิบ ปลากะพงสด, น้ำมะนาว, น้ำปลา, น้ำตาลปี๊ป, กระเทียม, พริกขี้หนูสวน, รากผักชี, ผักชี, ขึ้นฉ่าย และกะหล่ำปลี วิธีทำ ซอยกะหล่ำปลีให้เป็นเส้นๆ ไว้รองด้านล่างปลากะพง จากนั้นตั้งน้ำร้อนในซึ้งให้ร้อน เตรียมน้ำราดโดยนำ รากผักชีใส่ลงไปในโถปั่น ตามด้วยกระเทียม พริกขี้หนูสวน ปรุงรสด้วยน้ำมะนาว น้ำปลา น้ำตาลตามชอบ ปั่นพอหยาบ นำน้ำมาราดบนตัวปลากะพงพอประมาณ แล้วนำปลาลงไปนึ่งในซึ้งประมาณ 10 นาที ราดน้ำที่เหลือทั้งหมด โรยผักที่ซอยไว้ให้สวยงาม'),
                  _buildFoodCard(context, 'ไก่ผัดขิง', 'assets/image/5.png',
                      'ขิงมีคุณสมบัติช่วยแก้อาการคลื่นไส้อาเจียน และด้วยรสหวานเผ็ดร้อนของขิงจะขับลม แก้ท้องอืด จุกเสียด โดยมีเนื้อไก่ที่อุดมด้วยโปรตีนเสริมสร้างอวัยวะและกล้ามเนื้อของแม่และลูกในครรภ์'),
                  _buildFoodCard(context, 'ยำผลไม้รวม', 'assets/image/6.png',
                      'ช่วยให้คุณแม่ตั้งท้องเจริญอาหารมากขึ้น ด้วยรสชาติหวานอมเปรี้ยวอร่อย และอุดมด้วยวิตามินและแร่ธาตุที่มากมายจากผลไม้หลากหลายชนิด โดยเฉพาะวิตามินซี สร้างภูมิต้านทาน ช่วยดูดซึมธาตุเหล็กและเสริมความแข็งแรงให้กับลูกน้อยในครรภ์'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, String title, String imagePath,
      String description) {
    return GestureDetector(
      onTap: () {
        _showFoodDetailsDialog(context, title, imagePath, description);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 15), // ปรับขนาดอักษร
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันเพื่อแสดงป๊อปอัพรายละเอียดอาหาร
  void _showFoodDetailsDialog(BuildContext context, String title,
      String imagePath, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDAFAFA), // สีพื้นหลังของป๊อปอัพ
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // ปรับขนาดอักษรของ title ที่นี่
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // ปรับขนาดของคอนเทนต์ให้เล็กที่สุด
            children: [
              Image.asset(imagePath, height: 100, fit: BoxFit.cover),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                    fontSize: 16), // ปรับขนาดอักษรของ description ที่นี่
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิดป๊อปอัพ
              },
              child: Text('ปิด'),
            ),
          ],
        );
      },
    );
  }
}
