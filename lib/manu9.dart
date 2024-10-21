import 'package:flutter/material.dart';
import 'package:projectlasttt/Notification.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu9.dart';
import 'package:projectlasttt/manu10.dart'; // นำเข้าหน้า manu10
import 'package:projectlasttt/manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu9(),
    );
  }
}

class Manu9 extends StatefulWidget {
  @override
  _Manu9State createState() => _Manu9State();
}

class _Manu9State extends State<Manu9> {
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
      // ลบแถบเมนูด้านล่างออก
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Image.asset('assets/image/Warn.png', width: 40, height: 40),
      //       label: 'แจ้งเตือน',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset('assets/image/Home.png', width: 40, height: 40),
      //       label: 'หน้าหลัก',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset('assets/image/Profile.png', width: 40, height: 40),
      //       label: 'โปรไฟล์',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.lightBlue,
      //   onTap: _onItemTapped,
      // ),
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
                'ช่วง 4 - 6 เดือน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _buildFoodCard(
                      'ผัดผักรวม',
                      'assets/image/7.png',
                      'ผักชนิดต่าง ๆ อุดมด้วยใยอาหารที่ช่วยลดปัญหาท้องผูก ทั้งยังอุดมด้วยวิตามินและสารอาหารที่เสริมภูมิคุ้มกันให้กับร่างกายคุณแม่และลูกน้อย',
                      context),
                  _buildFoodCard(
                      'แกงส้มผักรวม',
                      'assets/image/8.png',
                      'ผักหลากชนิดที่นำมาปรุงเมนูนี้ ไม่ว่าจะเป็น แครอท กะหล่ำปลี ข้าวโพดอ่อนล้วนอุดมด้วยวิตามินหลากชนิดพร้อมมีเส้นใยอาหารดีต่อสุขภาพ มะขามเปียกช่วยปรุงรสเปรี้ยวมีวิตามินซีเสริมสร้างภูมิคุ้มกันได้',
                      context),
                  _buildFoodCard(
                      'ต้มยำทะเล',
                      'assets/image/21.png',
                      'อาหารทะเลอุดมไปด้วยแร่ธาตุ และสารอาหารต่าง ๆ เช่น ธาตุเหล็ก ไอโอดีน โอเมก้า ดีเอชเอ วิตามินแคลเซียม โปรตีน ที่จำเป็นต่อร่างกายของคุณแม่ พร้อมเสริมสร้างพัฒนาการร่างกายและสมองของทารกในครรภ์',
                      context),
                  _buildFoodCard(
                      'ตับผัดกระเพรา',
                      'assets/image/9.png',
                      'ในใบกระเพราและตับ ต่างมีธาตุเหล็กสูง ช่วยเสริมสร้างเม็ดเลือดให้กับร่างกายให้เพียงพอต่อการนำสารอาหารและออกซิเจนไปเลี้ยงทารกที่อยู่ในครรภ์ ',
                      context),
                  _buildFoodCard(
                      'ต้มส้มปลาทู',
                      'assets/image/10.png',
                      'มีปลาทูอันอุดมไปด้วยโปรตีน กรดไขมันโอเมก้า 3 และ DHA สูง มีประโยชน์สำหรับการพัฒนาสมองของลูกในครรภ์ การปรุงรสเปรี้ยวด้วยมะนาวเพิ่มวิตามินซีเสริมสร้างภูมิคุ้มกันได้อย่างดี',
                      context),
                  _buildFoodCard(
                      'ข้าวกล้องคลุกกะปิ',
                      'assets/image/11.png',
                      'มีสารอาหารครบทั้ง 5 หมู่และให้พลังงานได้มาก ยิ่งปรับเปลี่ยนมาเป็นข้าวกล้องที่มีแคลเซียม ธาตุเหล็กอยู่มากจึงช่วยบำรุงเลือดและกระดูกทั้งคุณแม่และลูกในครรภ์ นอกจากนี้กะปิยังอุดมด้วยวิตามินบี 12 พร้อมจุลินทรีย์ที่ป้องกันโรคลำไส้อักเสบ',
                      context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(String title, String imagePath, String description,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFoodDetailsDialog(title, imagePath, description, context);
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
  void _showFoodDetailsDialog(String title, String imagePath,
      String description, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDAFAFA), // เปลี่ยนสีพื้นหลัง
          title: Center(
            // ทำให้หัวข้ออยู่ตรงกลาง
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
