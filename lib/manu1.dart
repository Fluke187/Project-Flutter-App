import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // สำหรับการเข้ารหัสและถอดรหัสข้อมูล JSON
import 'package:intl/intl.dart';

import 'Data/ApiService.dart';
import 'Models/RPregnancyModel.dart';
import 'Models/DeleteRPregnancy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manu1(),
    );
  }
}

class Manu1 extends StatefulWidget {
  @override
  _Manu1State createState() => _Manu1State();
}

class _Manu1State extends State<Manu1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController bloodSugarController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController fetalMovementController = TextEditingController();
  int? selectedDose;
  int? editingIndex;

  List<RecordP> checkupData = [];
  List<String> dope = [
    'เข็มที่ 1',
    'เข็มที่ 2',
    'เข็มที่ 3',
    'ไม่ได้ฉีดวัคซีน'
  ];
  RPregnancyGetModel? pregnancyData;
  final CheckupDataManager _dataManager = CheckupDataManager();

  late Future<bool> loadDataFuture;
  @override
  void initState() {
    super.initState();
    loadDataFuture = _loadCheckupData();
  }

  Future<void> _loadData() async {
    await _dataManager.loadCheckupData();
    setState(() {});
  }

  Future<void> _refreshData() async {
    setState(() {
      loadDataFuture = _loadCheckupData();
    });
  }

  void _deleteCheckup(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการลบ'),
          content: Text('คุณแน่ใจหรือไม่ว่าต้องการลบข้อมูลนี้?'),
          actions: [
            OutlinedButton(
              child: Text('ลบ'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent, // สีพื้นหลัง
                side: BorderSide(color: Colors.lightBlueAccent), // สีขอบ
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                int? idToDelete = checkupData[index].id;
                if (idToDelete != null) {
                  try {
                    ApiService apiService = ApiService();
                    Deleterpregnancy result =
                    await apiService.deletePregnancy(idToDelete);
                    if (result.success == true) {
                      // ตรวจสอบ success property ของ Deleterpregnancy
                      setState(() {
                        checkupData.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ลบข้อมูลสำเร็จ')),
                      );
                      await _refreshData();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ไม่สามารถลบข้อมูลได้ กรุณาลองใหม่อีกครั้ง')),
                      );
                    }
                  } catch (e) {
                    print('Error deleting checkup: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('เกิดข้อผิดพลาดในการลบข้อมูล')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('ไม่พบข้อมูลที่ต้องการลบ')),
                  );
                }
              },
            ),
            OutlinedButton(
              child: Text('ยกเลิก'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.redAccent, // สีพื้นหลัง
                side: BorderSide(color: Colors.redAccent), // สีขอบ
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<bool> _loadCheckupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var RId = prefs.getInt("Pid");
    if (RId == null) {
      print("ไม่พบ Pid ใน SharedPreferences");
      return false;
    }

    ApiService apiService = ApiService();
    var Roc = await apiService.GetPrenancyModel(RId);
    if (Roc != null && Roc.recordP != null) {
      print("ข้อมูลที่โหลดมา: ${Roc.recordP!.map((r) => r.toJson()).toList()}");
      setState(() {
        checkupData = Roc.recordP!;
      });
      print("จำนวนข้อมูลที่โหลด: ${checkupData.length}");
      return true;
    } else {
      print("ไม่พบข้อมูลการตรวจครรภ์");
      return false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _addOrUpdateCheckup() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? pid = prefs.getInt("Pid");

      if (pid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่พบข้อมูลผู้ใช้ กรุณาเข้าสู่ระบบใหม่')),
        );
        return;
      }

      String formattedDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd-MM-yyyy').parse(dateController.text));

      RecordP newRecord = RecordP(
        id: editingIndex,
        pid: pid,
        inspectionDate: formattedDate, // ใช้วันที่ที่ถูกแปลงแล้ว
        pressure: int.tryParse(bloodPressureController.text),
        heart: int.tryParse(heartRateController.text),
        child: int.tryParse(fetalMovementController.text),
        needle: selectedDose,
      );

      print('Sending data to RPrenancy: '
          'Id: ${newRecord.id}, '
          'Pid: $pid, '
          'InspectionDate: ${newRecord.inspectionDate}, '
          'Pressure: ${newRecord.pressure}, '
          'Heart: ${newRecord.heart}, '
          'Child: ${newRecord.child}, '
          'needle: ${newRecord.needle}');

      ApiService apiService = ApiService();
      bool success;

      try {
        if (editingIndex != null) {
          // Update existing record
          success = await apiService.updatePregnancyCheckup(
            id: editingIndex!,
            pid: pid,
            inspectionDate: newRecord.inspectionDate ?? '',
            pressure: newRecord.pressure?.toDouble() ?? 0,
            heart: newRecord.heart?.toDouble() ?? 0,
            child: newRecord.child?.toDouble() ?? 0,
            needle: newRecord.needle ?? 0,
          );
        } else {
          // Add new record
          success = await apiService.RPrenancy(
            null,
            pid,
            newRecord.inspectionDate ?? '',
            newRecord.pressure?.toDouble() ?? 0,
            newRecord.heart?.toDouble() ?? 0,
            newRecord.child?.toDouble() ?? 0,
            newRecord.needle ?? 0,
          );
        }

        if (success) {
          setState(() {
            if (editingIndex != null) {
              int index = checkupData
                  .indexWhere((element) => element.id == editingIndex);
              if (index != -1) {
                checkupData[index] = newRecord;
              }
            } else {
              checkupData.add(newRecord);
            }
          });
          Navigator.pop(context);
          await _refreshData();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('บันทึกข้อมูลสำเร็จ')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('เกิดข้อผิดพลาดในการบันทึกข้อมูล')),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
        );
      }

      _clearFields();
    }
  }

  void _clearFields() {
    dateController.clear();
    bloodPressureController.clear();
    bloodSugarController.clear();
    heartRateController.clear();
    fetalMovementController.clear();
    selectedDose = null;
  }

  void _showAddCheckupDialog({RecordP? checkup, int? index}) {
    if (checkup != null) {
      dateController.text = checkup.inspectionDate!;
      bloodPressureController.text = checkup.pressure!.toString();
      heartRateController.text = checkup.heart!.toString();
      fetalMovementController.text = checkup.child!.toString();
      selectedDose = checkup.needle;
      editingIndex = checkup.id;
    } else {
      _clearFields();
      editingIndex = null;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              '${editingIndex != null ? 'แก้ไข' : 'เพิ่ม'} การตรวจครรภ์',
              style: TextStyle(fontSize: 20)),
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
                  SizedBox(height: 15),
                  DropdownButtonFormField<int>(
                    value: selectedDose,
                    decoration: InputDecoration(
                      labelText: 'เข็มวัคซีนบาดทะยัก',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem<int>(
                          value: 1,
                          child: Text('เข็มที่ 1',
                              style: TextStyle(fontSize: 18))),
                      DropdownMenuItem<int>(
                          value: 2,
                          child: Text('เข็มที่ 2',
                              style: TextStyle(fontSize: 18))),
                      DropdownMenuItem<int>(
                          value: 3,
                          child: Text('เข็มที่ 3',
                              style: TextStyle(fontSize: 18))),
                      DropdownMenuItem<int>(
                          value: 0,
                          child: Text('ไม่ได้ฉีดวัคซีน',
                              style: TextStyle(fontSize: 18))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedDose = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'กรุณาเลือกเข็มวัคซีนบาดทะยัก';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addOrUpdateCheckup,
                  child: Text('${editingIndex != null ? 'แก้ไข' : 'บันทึก'}',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    minimumSize: Size(70, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('ยกเลิก',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: Size(80, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCheckupCard(RecordP checkup, int index) {
    return Card(
      child: ListTile(
        title: Text(
          "วันที่: ${checkup.inspectionDate}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ความดันโลหิต: ${checkup.pressure}",
                style: TextStyle(fontSize: 15)),
            Text("การเต้นของหัวใจเด็ก: ${checkup.heart}",
                style: TextStyle(fontSize: 15)),
            Text("การดิ้นของเด็ก: ${checkup.child}",
                style: TextStyle(fontSize: 15)),
            Text("วัคซีนบาดทะยัก: ${_getVaccineText(checkup.needle)}",
                style: TextStyle(fontSize: 15)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.lightBlueAccent),
              onPressed: () =>
                  _showAddCheckupDialog(checkup: checkup, index: index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _deleteCheckup(index),
            ),
          ],
        ),
      ),
    );
  }

  String _getVaccineText(int? needle) {
    switch (needle) {
      case 1:
        return 'เข็มที่ 1';
      case 2:
        return 'เข็มที่ 2';
      case 3:
        return 'เข็มที่ 3';
      case 0:
        return 'ไม่ได้ฉีดวัคซีน';
      default:
        return 'ไม่ระบุ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'การตรวจครรภ์',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: loadDataFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (snapshot.data == true) {
            print("FutureBuilder: Data loaded successfully");
            if (checkupData.isEmpty) {
              return Center(child: Text('ไม่พบข้อมูลการตรวจครรภ์'));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    ...checkupData.asMap().entries.map((entry) {
                      int idx = entry.key;
                      RecordP data = entry.value;
                      print("Building card for index $idx: ${data.toJson()}");
                      return _buildCheckupCard(data, idx);
                    }).toList(),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('ไม่สามารถโหลดข้อมูลได้'));
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () => _showAddCheckupDialog(),
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add, size: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 8.0,
          tooltip: 'เพิ่มข้อมูล',
          heroTag: null,
        ),
      ),
    );
  }
}

class CheckupDataManager {
  RPregnancyGetModel? pregnancyData;

  Future<void> loadCheckupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? rId = prefs.getInt("Pid");
    if (rId == null) {
      print("Warning: Pid not found in SharedPreferences");
      return;
    }

    ApiService apiService = ApiService();
    pregnancyData = await apiService.GetPrenancyModel(rId);
    if (pregnancyData == null || pregnancyData!.recordP == null) {
      print("Warning: Failed to load pregnancy records");
      return;
    }

    print(
        "Loaded checkup data: ${pregnancyData!.recordP!.map((record) => record.toJson()).toList()}");
  }

  Future<bool> deleteCheckup(int id) async {
    try {
      print("Attempting to delete checkup with ID: $id");
      Deleterpregnancy result = await ApiService().deletePregnancy(id);
      print("Delete API response: ${result.toJson()}");

      if (result.success == true) {
        pregnancyData?.recordP?.removeWhere((item) => item.id == id);
        print(
            "Checkup deleted. Remaining data: ${pregnancyData?.recordP?.map((record) => record.toJson()).toList()}");
        return true;
      } else {
        print("Failed to delete checkup. API returned success: false");
        return false;
      }
    } catch (e) {
      print("Error deleting checkup: $e");
      return false;
    }
  }
}
