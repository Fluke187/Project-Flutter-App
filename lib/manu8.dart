import 'package:flutter/material.dart';

// เพิ่มหน้าต่าง ๆ ที่จะใช้
import 'package:projectlasttt/Notification.dart'; // ทำการ import หน้าแจ้งเตือน
import 'package:projectlasttt/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Data/ApiService.dart';
import 'Models/NotiGetModel.dart'; // ทำการ import หน้าประวัติ

void main() {
  runApp(MyApp());
}

// เปลี่ยนจาก StatelessWidget เป็น StatefulWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Manu8(),
    );
  }
}

class Manu8 extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<Manu8> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<String> _appointments = []; // เก็บรายการนัดหมาย
  Notigetmodel? notigetmodel;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showAddAppointmentDialog([int? index]) {
    TextEditingController summaryController = TextEditingController();
    if (index != null) {
      summaryController.text = _appointments[index].split(' - ')[1];
      _selectedDate = DateTime.parse(_appointments[index].split(' ')[1]);
      _selectedTime = TimeOfDay(
        hour: int.parse(_appointments[index].split(' ')[3].split(':')[0]),
        minute: int.parse(_appointments[index].split(' ')[3].split(':')[1]),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'เพิ่ม นัดพบแพทย์' : 'แก้ไขนัดพบแพทย์'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _selectDate(context), // เปิดปฏิทินเมื่อกดที่วันที่
                child: Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white, // สีพื้นหลังของช่อง
                  ),
                  child: Center(
                    child: Text(
                      "${_selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectTime(context), // เปิดตัวเลือกเวลาเมื่อกดที่เวลา
                child: Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white, // สีพื้นหลังของช่อง
                  ),
                  child: Center(
                    child: Text(
                      "${_selectedTime.format(context)}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final newAppointment =
                            'วันที่ ${_selectedDate.toLocal().toString().split(' ')[0]} เวลา ${_selectedTime.format(context)} - ${summaryController.text}';
                        if (index == null) {
                          _appointments.add(newAppointment); // เพิ่มนัดหมายใหม่
                        } else {
                          _appointments[index] = newAppointment; // แก้ไขนัดหมาย
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Text('บันทึก'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white, // สีข้อความในปุ่มบันทึก
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // ช่องว่างระหว่างปุ่ม
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('ยกเลิก'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white, // สีข้อความในปุ่มยกเลิก
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteAppointment(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ยืนยันการลบ',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          content: Text(
            'คุณแน่ใจหรือไม่ว่าต้องการลบข้อมูลนี้?',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          actions: [
            Center( // ใช้ Center เพื่อจัดตำแหน่งปุ่ม
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิดป๊อปอัพ
                    },
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      minimumSize: Size(80, 20),
                    ),
                  ),
                  SizedBox(width: 10), // ช่องว่างระหว่างปุ่ม
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _appointments.removeAt(index); // ลบการนัดหมาย
                      });
                      Navigator.of(context).pop(); // ปิดป๊อปอัพ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ลบข้อมูลสำเร็จ')),
                      );
                    },
                    child: Text(
                      'ลบ',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: Size(80, 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> getnotix() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? Pid = prefs.getInt('Pid');
    if (Pid != null) {
      var response = await ApiService().GetNoti(Pid);
      // await DatabaseHelper.instance.GetDatabase();
      // await DatabaseHelper.instance.LoadAlarm();
      notigetmodel = response;
    } else {
      print('Error: Pid not found');
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'นัดพบแพทย์',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold, // ปรับให้เป็นตัวหนา
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: getnotix(),
        builder: (BuildContext context,AsyncSnapshot<bool>snapshot){
          if (snapshot.hasData){
            return Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: notigetmodel?.recordNoti?.length,
                        itemBuilder: (context, index) {
                          var noti = notigetmodel?.recordNoti?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1), // ระยะห่างระหว่างรายการ
                            child: Card(
                              color: Colors.white, // สีพื้นหลังของแต่ละการ์ด
                              elevation: 2, // เพิ่มเงา
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15), // ปรับความโค้งของกรอบ
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(10.0), // เพิ่มระยะห่างภายในการ์ด
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: '${noti?.inspectionDate!??''}\n',
                                          style: TextStyle(fontWeight: FontWeight.bold), // ปรับหัวข้อให้เป็นตัวหนา
                                        ),
                                        TextSpan(text: 'รายละเอียด: ${_appointments[index].split(' - ')[0]}'),
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                                      onPressed: () => _showAddAppointmentDialog(index), // แก้ไขการนัดหมาย
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.redAccent),
                                      onPressed: () => _deleteAppointment(index), // ลบการนัดหมาย
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
          }else
            return Center();
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(17.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       SizedBox(height: 10),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: notigetmodel?.recordNoti?.length,
      //           itemBuilder: (context, index) {
      //             var noti = notigetmodel?.recordNoti?[index];
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 1), // ระยะห่างระหว่างรายการ
      //               child: Card(
      //                 color: Colors.white, // สีพื้นหลังของแต่ละการ์ด
      //                 elevation: 2, // เพิ่มเงา
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(15), // ปรับความโค้งของกรอบ
      //                 ),
      //                 child: ListTile(
      //                   title: Padding(
      //                     padding: const EdgeInsets.all(10.0), // เพิ่มระยะห่างภายในการ์ด
      //                     child: RichText(
      //                       text: TextSpan(
      //                         style: TextStyle(fontSize: 15, color: Colors.black),
      //                         children: [
      //                           TextSpan(
      //                             text: '${noti?.inspectionDate!.split(' - ')[0]}\n',
      //                             style: TextStyle(fontWeight: FontWeight.bold), // ปรับหัวข้อให้เป็นตัวหนา
      //                           ),
      //                           TextSpan(text: 'รายละเอียด: ${_appointments[index].split(' - ')[1]}'),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   trailing: Row(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: <Widget>[
      //                       IconButton(
      //                         icon: Icon(Icons.edit, color: Colors.blueAccent),
      //                         onPressed: () => _showAddAppointmentDialog(index), // แก้ไขการนัดหมาย
      //                       ),
      //                       IconButton(
      //                         icon: Icon(Icons.delete, color: Colors.redAccent),
      //                         onPressed: () => _deleteAppointment(index), // ลบการนัดหมาย
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAppointmentDialog(), // เพิ่มการนัดหมายใหม่
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent, // ปรับสีของปุ่มเพิ่มนัดหมาย
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

