import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectlasttt/Models/NotiGetModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Data/ApiService.dart';

class AddDoctorPage extends StatefulWidget {
  AddDoctorPage({Key? key, this.item = null}) : super(key: key);
  final RecordNoti? item;
  @override
  _AddDoctorPageState createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final List<int> hours = List.generate(24, (index) => index);
  final List<int> minutes = List.generate(60, (index) => index);
  DateTime? _selectedDate;
  int? _selectedHour;
  int? _selectedMinute;

  @override
  void initState() {
    _selectedDate = widget.item?.inspectionDate;
  }

  // Formatter for displaying the date
  String get _formattedDate {
    if (_selectedDate == null) {
      return 'เลือกวันที่นัดหมาย';
    } else {
      return DateFormat('dd/MM/yyyy').format(_selectedDate!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      // setState(() {
      _selectedDate = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, _selectedHour ?? 8, _selectedMinute ?? 0);
      // });
    }
  }

  Future<Notigetmodel?> PageLoadDoctor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int Pid = prefs.getInt('Pid') ?? 0;
    var MedicalLoad = await ApiService().GetNoti(Pid);
    return MedicalLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'การบันทึกนัดพบแพทย์',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Notigetmodel?>(
          future: PageLoadDoctor(),
          builder:
              (BuildContext context, AsyncSnapshot<Notigetmodel?> snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.lightBlue[50],
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '*จะแจ้งเตือนเมือถึงเวลา และ จะแจ้งเตือนร่วงหน้า',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'วันที่นัดหมาย',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formattedDate,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('เวลา'),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                labelText: 'ชั่วโมง',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              value: _selectedHour,
                              items: hours.map((int hour) {
                                return DropdownMenuItem(
                                  value: hour,
                                  child: Text(hour.toString().padLeft(2, '0')),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedHour = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                labelText: 'นาที',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              value: _selectedMinute,
                              items: minutes.map((int minute) {
                                return DropdownMenuItem(
                                  value: minute,
                                  child:
                                      Text(minute.toString().padLeft(2, '0')),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMinute = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            textStyle: TextStyle(fontSize: 18),
                            backgroundColor: Colors.lightBlueAccent, // เปลี่ยนสีปุ่มตรงนี้
                            foregroundColor: Colors.white, // เปลี่ยนสีตัวอักษรเป็นสีขาว
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            int Pid = prefs.getInt('Pid') ?? 0;
                            int? id = null;
                            if (widget.item?.id != null &&
                                widget.item?.id != 0) {
                              id = widget.item!.id!;
                            }
                            for (int i=0;i<=1;i++){
                            _selectedDate = DateTime(
                                _selectedDate!.year,
                                _selectedDate!.month,
                                _selectedDate!.day-i,
                                _selectedHour ?? 8,
                                _selectedMinute ?? 0);
                            var result = await ApiService()
                                .insetupdate(id, Pid, _selectedDate!);
                            if (DateTime.now().compareTo(_selectedDate!) <= 0) {
                              final alarmsetting = new AlarmSettings(
                                id: DateTime
                                    .now()
                                    .millisecondsSinceEpoch % 10000,
                                dateTime: _selectedDate!,
                                assetAudioPath: 'assets/Audio/clock.mp3',
                                loopAudio: false,
                                notificationTitle: 'แจ้งเตือน',
                                notificationBody: 'แจ้งเตือนนัดพบแพทย์พรุ่งนี้',
                              );
                              await Alarm.set(alarmSettings: alarmsetting);
                            }
                            }
                              Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text('บันทึกการนัดพบแพทย์'),

                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (widget.item?.id != null && widget.item?.id != 0)
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // ป้องกันการปิดหน้าโหลดโดยคลิกนอกกรอบ
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );

                                    try {
                                      var DeleteResponse = await ApiService()
                                          .deletenoti(widget.item!.id!);
                                      if (DeleteResponse != null &&
                                          DeleteResponse.success == true) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        Navigator.pop(
                                          context,
                                        );
                                      } else {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'ไม่พบชื่อผู้ใช้หรือรหัสผ่านผิด'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      // ปิดหน้าโหลดเมื่อเกิดข้อผิดพลาด
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('เกิดข้อผิดพลาด: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('ลบข้อมูลวันนัดพบแพทย์',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                )
                              : Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center();
            }
          }),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.lightBlueAccent,
          contentPadding: EdgeInsets.all(16.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
