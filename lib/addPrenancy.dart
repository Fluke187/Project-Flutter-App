import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // นำเข้า intl package
import 'package:projectlasttt/login.dart';
import 'package:projectlasttt/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Data/ApiService.dart';
import 'manu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddPrenancy(),
    );
  }
}

class AddPrenancy extends StatefulWidget {
  AddPrenancy ({super.key}){

  }
  @override
  _Re2State createState() => _Re2State();
}

class _Re2State extends State<AddPrenancy> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  DateTime? _pregnancyDate;

  String get _formattedDate {
    if (_pregnancyDate == null) {
      return 'เลือกวันที่นัดหมาย';
    } else {
      return DateFormat('dd/MM/yyyy').format(_pregnancyDate!);
    }
  }

  Future<void> _validateAndSubmit() async {
    String weight = _weightController.text.trim();
    String height = _heightController.text.trim();


    ApiService apiService = ApiService();
    if (weight.isEmpty || height.isEmpty || _pregnancyDate!.toIso8601String().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int UId = prefs.getInt('UId') ?? 0;
      var responsedata = await apiService.addPregnancy(UId,double.parse(_weightController.text),double.parse(_heightController.text), _pregnancyDate );
      if (responsedata != null){
        prefs.setInt("Pid", responsedata!.pId!);
      }else{
        
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecordPage()),
      );
    }
  }

  Future<void> _selectPregnancyDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        // ใช้ DateFormat เพื่อจัดรูปแบบวันที่
        _pregnancyDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 8, 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDAFAFA),
        elevation: 0, // Remove the shadow
      ),
      backgroundColor: Color(0xFFDAFAFA), // Light background color
      body: SingleChildScrollView( // Allow scrolling if necessary
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), // Add vertical padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: <Widget>[
              CircleAvatar(
                radius: 110.0,
                backgroundColor: Colors.transparent, // Transparent background
                backgroundImage: AssetImage('assets/image/0003.png'), // Icon image
              ),
              SizedBox(height: 10.0),
              Text(
                'ข้อมูลการตั้งครรภ์',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              _buildSizedTextField('น้ำหนัก', _weightController),
              SizedBox(height: 10),
              _buildSizedTextField('ส่วนสูง', _heightController),
              SizedBox(height: 10),
              InkWell(
                onTap: () => _selectPregnancyDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'วันที่ตั้งครรภ์',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20), // เพิ่มความโค้งมนที่มุม
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), // ลดขนาดพื้นที่ภายในให้สั้นลง
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formattedDate,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () => _selectPregnancyDate(context), // Show date picker on tap
              //   child: AbsorbPointer( // Disable keyboard for this field
              //     child: _buildSizedTextField('วันที่ตั้งครรภ์', _formattedDate as TextEditingController),
              //   ),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndSubmit,

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    'เสร็จสิ้น',
                    style: TextStyle(fontSize: 15, color: Colors.white), // Change text color here
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent, // Button color
                  foregroundColor: Colors.white, // Set text color here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create a sized TextField
  Widget _buildSizedTextField(String label, TextEditingController controller) {
    return SizedBox(
      width: 300, // Width of the TextField
      height: 46, // Height of the TextField
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0), // Rounded corners
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Padding inside
        ),
      ),
    );
  }
}
