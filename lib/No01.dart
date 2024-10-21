import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // สำหรับการเข้ารหัสและถอดรหัสข้อมูล JSON
import 'package:intl/intl.dart';

import 'Data/ApiService.dart';
import 'Models/RPregnancyModel.dart'; // สำหรับจัดการรูปแบบวันที่

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu99(),
    );
  }
}

class Manu99 extends StatefulWidget {
  @override
  _Manu1State createState() => _Manu1State();
}

class _Manu1State extends State<Manu99> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController bloodSugarController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController fetalMovementController = TextEditingController();

  String? selectedDose; // สำหรับวัคซีนบาดทะยัก
  int? editingIndex; // สำหรับการแก้ไข
  List<RecordP> checkupData = []; // สำหรับเก็บข้อมูลการตรวจครรภ์

  @override
  void initState() {
    super.initState();
    //_loadCheckupData(); // โหลดข้อมูลเมื่อเริ่มต้นแอป
  }

  // โหลดข้อมูลการตรวจครรภ์จาก SharedPreferences
  Future<bool> _loadCheckupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var RId = prefs.getInt("Pid");
    ApiService apiService = ApiService();
    var Roc = await apiService.GetPrenancyModel(RId??0);
    checkupData = Roc?.recordP??[];
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? storedData = prefs.getString('checkupData');
    // if (storedData != null) {
    //   setState(() {
    //     checkupData = List<Map<String, String>>.from(json.decode(storedData));
    //   });
    // }
    return true;
  }

  // บันทึกข้อมูลการตรวจครรภ์ไปยัง SharedPreferences
  Future<void> _saveCheckupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('checkupData', json.encode(checkupData));
  }

  // เลือกวันที่จากปฏิทิน
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // ตรวจสอบว่ามีการเลือกวันที่หรือไม่
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  // เพิ่มหรือแก้ไขข้อมูลการตรวจครรภ์
  void _addOrUpdateCheckup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // if (editingIndex != null) {
        //   // แก้ไขข้อมูลที่มีอยู่
        //
        //   checkupData[editingIndex!] = {
        //     'date': dateController.text,
        //     'bloodPressure': bloodPressureController.text,
        //     'bloodSugar': bloodSugarController.text,
        //     'heartRate': heartRateController.text,
        //     'fetalMovement': fetalMovementController.text,
        //     'tetanusVaccine': selectedDose ?? 'ยังไม่ได้เลือก',
        //   };
        //   editingIndex = null; // รีเซ็ตตัวแปรแก้ไข
        // } else {
        //   // เพิ่มข้อมูลใหม่
        //   checkupData.add({
        //     'date': dateController.text,
        //     'bloodPressure': bloodPressureController.text,
        //     'bloodSugar': bloodSugarController.text,
        //     'heartRate': heartRateController.text,
        //     'fetalMovement': fetalMovementController.text,
        //     'tetanusVaccine': selectedDose ?? 'ยังไม่ได้เลือก',
        //   });
        // }
        _saveCheckupData(); // บันทึกข้อมูลใน SharedPreferences
      });

      // แสดง Snackbar แสดงผลสำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(editingIndex == null ? 'บันทึกข้อมูลสำเร็จ' : 'แก้ไขข้อมูลสำเร็จ')),
      );

      // เคลียร์ฟิลด์ข้อมูลหลังจากบันทึก
      _clearFields();
      Navigator.pop(context); // ปิดป๊อปอัพหลังจากบันทึกเสร็จ
    }
  }

  // เคลียร์ฟิลด์ข้อมูล
  void _clearFields() {
    dateController.clear();
    bloodPressureController.clear();
    bloodSugarController.clear();
    heartRateController.clear();
    fetalMovementController.clear();
    selectedDose = null;
  }

  // แสดง Dialog สำหรับเพิ่มหรือแก้ไขข้อมูล
  void _showAddCheckupDialog({RecordP? checkup, int? index}) {
    if (checkup != null) {
      dateController.text = checkup.inspectionDate!;
      bloodPressureController.text = checkup.pressure!.toString();
      heartRateController.text = checkup.heart!.toString();
      fetalMovementController.text = checkup.child!.toString();
      selectedDose = checkup.needle.toString();
      editingIndex = checkup.id;
    } else {
      _clearFields();
      editingIndex = null;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${editingIndex != null ? 'แก้ไข' : 'เพิ่ม'} การตรวจครรภ์', style: TextStyle(fontSize: 20)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'วันที่',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 15),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกวันที่';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: bloodPressureController,
                    decoration: InputDecoration(
                      labelText: 'ความดันโลหิต',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกความดันโลหิต';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: heartRateController,
                    decoration: InputDecoration(
                      labelText: 'อัตราการเต้นของหัวใจเด็ก',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกอัตราการเต้นของหัวใจเด็ก';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: fetalMovementController,
                    decoration: InputDecoration(
                      labelText: 'การดิ้นของเด็ก',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกการดิ้นของเด็ก';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedDose,
                    decoration: InputDecoration(
                      labelText: 'เข็มวัคซีนบาดทะยัก',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    items: ['เข็มที่ 1', 'เข็มที่ 2', 'เข็มที่ 3'].map((dose) {
                      return DropdownMenuItem<String>(
                        value: dose,
                        child: Text(dose, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDose = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'กรุณาเลือกวัคซีน';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () => _addOrUpdateCheckup(),
              child: Text('${editingIndex != null ? 'แก้ไข' : 'บันทึก'}'),
            ),
          ],
        );
      },
    );
  }

  // แสดงข้อมูลการตรวจครรภ์ในรายการ
  Widget _buildCheckupList() {
    return ListView.builder(
      itemCount: checkupData.length,
      itemBuilder: (context, index) {
        final checkup = checkupData[index];
        return Card(
          child: ListTile(
            title: Text('วันที่: ${checkup.inspectionDate}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ความดันโลหิต: ${checkup.pressure}'),
                Text('อัตราการเต้นของหัวใจ: ${checkup.heart}'),
                Text('การดิ้นของเด็ก: ${checkup.child}'),
                Text('วัคซีนบาดทะยัก: ${checkup.needle}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showAddCheckupDialog(checkup: checkup, index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      checkupData.removeAt(index);
                    });
                    _saveCheckupData(); // อัปเดตข้อมูลหลังการลบ
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ลบข้อมูลเรียบร้อย')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การตรวจครรภ์'),
      ),
      body: FutureBuilder(
        future: _loadCheckupData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData){
            return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(child: _buildCheckupList()),
                      ElevatedButton(
                        onPressed: () => _showAddCheckupDialog(),
                        child: Text('เพิ่มการตรวจครรภ์'),
                      ),
                    ],
                  ),
                );
          }else{
            return Spacer();
          }
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       Expanded(child: _buildCheckupList()),
      //       ElevatedButton(
      //         onPressed: () => _showAddCheckupDialog(),
      //         child: Text('เพิ่มการตรวจครรภ์'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
