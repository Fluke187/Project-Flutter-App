import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:projectlasttt/Data/ApiService.dart';
import 'package:projectlasttt/No01.dart';
import 'package:projectlasttt/account.dart';
import 'package:projectlasttt/list.dart';
import 'package:projectlasttt/login.dart';
import 'package:projectlasttt/manu1.dart';
import 'package:projectlasttt/manu8.dart';
import 'package:projectlasttt/manu3.dart';
import 'package:projectlasttt/manu4.dart';
import 'package:projectlasttt/manu6.dart';
import 'package:projectlasttt/manu7.dart';
import 'package:projectlasttt/record.dart';
import 'package:projectlasttt/Group1.dart';
import 'package:projectlasttt/Group2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ListNoti.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    liset(), // Notification screen
    menumainstate(), // Main menu screen
    LoginScreen(), // Profile screen
  ];

  void _onItemTapped(int index) {
    if (index == 2) { // Assuming index 2 is the Profile button
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ออกจากระบบ"),
            content: Text("คุณต้องการออกจากระบบหรือไม่?"),
            actions: [
              TextButton(
                child: Text("ยืนยัน"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
              TextButton(
                child: Text("ยกเลิก"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _selectedIndex == 2
          ? null // Hide the bottom navigation bar when on the login screen
          : BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/Warn.png', width: 40, height: 40),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/Home.png', width: 40, height: 40),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/ExitIcon.png', width: 40, height: 40),
            label: 'ออกจากระบบ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class menumainstate extends StatefulWidget {
  int days = 0;
  menumainstate({super.key, this.days = 0});
  @override
  State<menumainstate> createState() => Menumain();
}

class Menumain extends State<menumainstate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      widget.days = prefs.getInt("days") ?? 0;
    });
    LoadAlarm();
  }
  Future<void> LoadAlarm() async {
    await Alarm.stopAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int Pid = prefs.getInt("Pid") ?? 0;
    var notification = await ApiService().GetNoti(Pid);
    if((notification?.recordNoti?.length ?? 0)>0){
      for (int i = 0;i <=1; i++) {
        for (var notiitem in notification!.recordNoti!) {
          DateTime tempdate = new DateTime(
              notiitem.inspectionDate!.year,
              notiitem.inspectionDate!.month,
              notiitem.inspectionDate!.day-i,
              notiitem.inspectionDate!.hour,
              notiitem.inspectionDate!.minute,
              notiitem.inspectionDate!.second,
              notiitem.inspectionDate!.microsecond);
          if (DateTime.now().compareTo(tempdate) <= 0) {
            final alarmsetting = new AlarmSettings(
              id: DateTime
                  .now()
                  .millisecondsSinceEpoch % 10000,
              dateTime: tempdate,
              assetAudioPath: 'assets/alarm-clock-01.mp3',
              notificationTitle: i==0?'แจ้งเตือนนัดพบ ': 'แจ้งเตือนร่วงหน้านัดพบ',
              notificationBody: 'แจ้งเตือนนัดพบแพทย์',
            );
            await Alarm.set(alarmSettings: alarmsetting);
          }
        }
      }
    }
  }

  Future<bool> Pageload() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //widget.days = prefs.getInt("days") ?? 0;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: Pageload(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Color(0xFFE0F7FA),
              appBar: AppBar(
                backgroundColor: Color(0xFFE0F7FA),
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false, // ปิดการแสดงปุ่มย้อนกลับ
                title: Text(
                  'เหลืออีกประมาณ${widget.days}วัน',
                  style: TextStyle(
                    color: Colors.black, // กำหนดสีข้อความให้เป็นสีดำ
                    fontWeight: FontWeight.bold, // ทำให้ข้อความตัวหนา
                    fontSize: 19, // ปรับขนาดตัวอักษรที่นี่
                  ),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 5), // เพิ่มระยะห่างหลังจากวันที่คลอด

                      // ปรับปุ่มให้เป็นแบบแนวนอนและยาว
                      HorizontalMenuButton(
                        icon: 'assets/image/055.png',
                        label: 'บันทึกและแสดงการตรวจครรภ์',
                        width: 340, // ความกว้างของปุ่ม
                        height: 110, // ความสูงของปุ่ม
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Manu1()),
                          );
                        },
                      ),

                      SizedBox(height: 10),

                      HorizontalMenuButton(
                        icon: 'assets/image/077.png',
                        label: 'บันทึกและแสดงการนัดพบแพทย์',
                        width: 340, // ความกว้างของปุ่ม
                        height: 110, // ความสูงของปุ่ม
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Doc1()),
                          );
                        },
                      ),

                      SizedBox(height: 15), // เพิ่มระยะห่าง

                      Expanded(
                        child: GridView.count(
                          crossAxisCount: screenWidth > 600
                              ? 3
                              : 2, // ปรับจำนวนช่องตามขนาดหน้าจอ
                          crossAxisSpacing: 10.0, // เพิ่มระยะห่างแนวนอน
                          mainAxisSpacing: 10.0, // เพิ่มระยะห่างแนวตั้ง
                          children: <Widget>[
                            MenuButton(
                              icon: 'assets/image/G1.png',
                              label: 'อาการและออกกำลังกาย',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Group1()),
                                );
                              },
                            ),
                            MenuButton(
                              icon: 'assets/image/G2.png',
                              label: 'อาหาร',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Group2()),
                                );
                              },
                            ),
                            MenuButton(
                              icon: 'assets/image/099.png',
                              label: 'สิ้นสุดการตั้งครรภ์',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("ยืนยันการลบ"),
                                      content: Text("คุณต้องการสิ้นสุดการตั้งครรภ์หรือไม่?"),
                                      actions: [
                                        OutlinedButton(
                                          child: Text("ยืนยัน"),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent, // สีพื้นหลัง
                                            side: BorderSide(color: Colors.lightBlueAccent), // สีขอบ
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RecordPage(),
                                              ),
                                            );
                                          },
                                        ),
                                        OutlinedButton(
                                          child: Text("ยกเลิก"),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white, backgroundColor: Colors.red, // สีพื้นหลัง
                                            side: BorderSide(color: Colors.red), // สีขอบ
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                             MenuButton(
                               icon: 'assets/image/100.png',
                               label: 'ประวัติการตั้งครรภ์',
                               onTap: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => RecordPage()),
                                 );
                               },
                             ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center();
          }
        });
  }
}

// ปุ่มแนวนอนแบบยาวที่ปรับขนาดได้
class HorizontalMenuButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  final double width;
  final double height;

  HorizontalMenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.width = 400, // Default width
    this.height = 100, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width, // Set custom width
        height: height, // Set custom height
        child: Container(
          padding: EdgeInsets.all(30),
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
            children: <Widget>[
              Image.asset(icon, width: 50, height: 50),
              SizedBox(width: 5.0),
              Text(
                label,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ปรับขนาดปุ่ม MenuButton
class MenuButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(icon, width: 50, height: 50),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
