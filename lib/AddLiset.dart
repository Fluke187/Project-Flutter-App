import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // สำหรับการเข้ารหัสและถอดรหัสข้อมูล JSON
import 'package:intl/intl.dart';

import 'Data/ApiService.dart';
import 'Models/RPregnancyModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Addliset(),
    );
  }
}

class Addliset extends StatefulWidget {
  @override
  _Manu1State createState() => _Manu1State();
}

class _Manu1State extends State<Addliset> {
  List<RecordP> checkupData = [];
  RPregnancyGetModel? pregnancyData;
  final CheckupDataManager _dataManager = CheckupDataManager();

  late Future<bool> loadDataFuture;
  @override
  void initState() {
    super.initState();
    loadDataFuture = _loadCheckupData();
  }

  Future<void> _refreshData() async {
    setState(() {
      loadDataFuture = _loadCheckupData();
    });
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
}
