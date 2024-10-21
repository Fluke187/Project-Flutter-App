import 'dart:convert';
import 'dart:ffi';
import 'package:alarm/alarm.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectlasttt/Models/AddPregnancy.dart';
import 'package:projectlasttt/Models/DeleteRPregnancy.dart';
import 'package:projectlasttt/Models/NotiGetModel.dart';
import 'package:projectlasttt/Models/PregnancyModel.dart';
import 'package:projectlasttt/Models/RPregnancyModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/LoginModel.dart';
import '../Models/DeleteRPregnancy.dart';
import '../Models/NotiDelete.dart';
import '../Models/NotificationModel.dart';
import '../Models/RegisterModel.dart';
import '../Models/SetSelectdedPregnanacyID.dart';

// ApiService class
class ApiService {
  static final _instance = new ApiService();
  static var instance = _instance;
  Future<LoginResponseModel?> login(String username, String password) async {
    var response = await http.post(
      Uri.parse('http://thanadon.3bbddns.com:56600/Api/Auth/Login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return LoginResponseModel.fromJson(json);
    } else {
      // Handle errors
      return null;
    }
  }

  Future<RegisterResponse?> register(
      String Username,
      String Password,
      String Email,
      double Weight,
      double Height,
      DateTime? DatePregnancy) async {
    var response = await http.post(
      Uri.parse('http://thanadon.3bbddns.com:56600/Api/Register/Register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Username': Username,
        'Password': Password,
        'Email': Email,
        'Weight': Weight,
        'Height': Height,
        'DatePregnancy': DatePregnancy!.toUtc().toIso8601String(),
      }),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return RegisterResponse.fromJson(json);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future<PregnancyResponseModel?> Pregnancy(
      int UId, Weight, Float Height, DateTime DatePregnancy) async {
    var response = await http.post(
      Uri.parse('http://thanadon.3bbddns.com:56600/Api/Pregnancy/Pregnancy'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'UId': UId,
        'Weight': Weight,
        'Height': Height,
        'DatePregnancy': DatePregnancy,
      }),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return PregnancyResponseModel.fromJson(json);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future<bool> RPrenancy(
    int? Id,
    int Pid,
    String InspectionDate,
    double Pressure,
    double Heart,
    double Child,
    int needle,
  ) async {
    String formattedDate = InspectionDate;
    try {
      formattedDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(InspectionDate));
    } catch (e) {
      print('Error formatting date: $e');
      // ถ้าแปลงไม่ได้ ให้ใช้ค่าเดิม
    }

    final data = <String, dynamic>{
      'Pid': Pid.toString(),
      'InspectionDate': formattedDate,
      'Pressure': Pressure.toString(),
      'Heart': Heart.toString(),
      'Child': Child.toString(),
      'needle': needle.toString(),
    };

    if (Id != null) {
      data['Id'] = Id.toString();
    }

    print('Sending data to API: $data'); // Log data being sent

    try {
      var response = await http.post(
        Uri.parse(
            'http://thanadon.3bbddns.com:56600/Api/RPregnancy/InsertARPregnancys'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<RPregnancyGetModel?> GetPrenancyModel(int id) async {
    var response = await http.post(
      Uri.parse(
          'http://thanadon.3bbddns.com:56600/Api/RPregnancy/GetPrenancy?Pid=${id}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return RPregnancyGetModel.fromJson(json);
    } else {
      // Handle errors
      return null;
    }
  }

  Future<Notigetmodel?> GetNoti(int Pid) async {
    var response = await http.post(
      Uri.parse(
          'http://thanadon.3bbddns.com:56600/Api/Notification/GetNoti?Pid=${Pid}'),
      headers: {
        'Content-Type': 'application/json',
      },
      // body: jsonEncode({
      //   'Pid': Pid,
      // }),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Notigetmodel.fromJson(json);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }


  Future<Deleterpregnancy> deletePregnancy(int id) async {
    final url = Uri.parse(
        'http://thanadon.3bbddns.com:56600/Api/RPregnancy/DeleteMedical');

    final response = await http.post(
      url,
      headers: {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id}),
    );
    print('Attempting to delete pregnancy with ID: $id');

    if (response.statusCode == 200) {
      return Deleterpregnancy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete pregnancy record');
    }
  }

  Future<bool> updatePregnancyCheckup({
    required int id,
    required int pid,
    required String inspectionDate,
    required double pressure,
    required double heart,
    required double child,
    required int needle,
  }) async {
    var uri = Uri.parse(
        'http://thanadon.3bbddns.com:56600/Api/RPregnancy/InsertARPregnancys');
    var request = http.MultipartRequest('POST', uri);

    request.fields['Id'] = id.toString();
    request.fields['Pid'] = pid.toString();
    request.fields['InspectionDate'] = inspectionDate;
    request.fields['Pressure'] = pressure.toString();
    request.fields['Heart'] = heart.toString();
    request.fields['Child'] = child.toString();
    request.fields['needle'] = needle.toString();

    print('Updating pregnancy checkup with data: '
        'id=$id, pid=$pid, inspectionDate=$inspectionDate, '
        'pressure=$pressure, heart=$heart, child=$child, needle=$needle');

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
  Future<insertupdateNoti?> insetupdate(
      int? Id,
      int Pid,
      DateTime Noti,
      ) async {

    final data = <String, dynamic>{
      'Pid': Pid.toString(),
      'Noti': Noti.toIso8601String(),
    };

    if (Id != null) {
      data['Id'] = Id.toString();
    }

    try {
      var response = await http.post(
        Uri.parse(
            'http://thanadon.3bbddns.com:56600/Api/Notification/InsertNoti'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return insertupdateNoti.fromJson(json);
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
  Future<NotiDelete> deletenoti(int id) async {
    final url = Uri.parse(
        'http://thanadon.3bbddns.com:56600/Api/Notification/DeleteNoti');

    final response = await http.post(
      url,
      headers: {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id}),
    );
    print('Attempting to delete pregnancy with ID: $id');

    if (response.statusCode == 200) {
      return NotiDelete.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete pregnancy record');
    }
  }
  Future<AddPregnancyResponseModel?> addPregnancy(
      int Uid,
      double Weight,
      double Height,
      DateTime? DatePregnancy) async {
    var response = await http.post(
      Uri.parse('http://thanadon.3bbddns.com:56600/Api/Pregnancy/Pregnancy'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Uid': Uid,
        'Weight': Weight,
        'Height': Height,
        'DatePregnancy': DatePregnancy!.toUtc().toIso8601String(),
      }),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return AddPregnancyResponseModel.fromJson(json);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
  Future<SetSelectdedPregnancyId?> SetPregnancyId(String username, String password) async {
    var response = await http.post(
      Uri.parse('http://thanadon.3bbddns.com:56600/Api/Pregnancy/SetSelectdedPanancyId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return SetSelectdedPregnancyId.fromJson(json);
    } else {
      // Handle errors
      return null;
    }
  }
  // Future<void> LoadAlarm() async {
  //   await Alarm.stopAll();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int Pid = prefs.getInt("Pid") ?? 0;
  //   var notification = await ApiService().GetNoti(Pid);
  //   if((notification?.recordNoti?.length ?? 0)>0){
  //     for (int i = 0;i <=1; i++) {
  //       for (var notiitem in notification!.recordNoti!) {
  //         DateTime tempdate = new DateTime(
  //             notiitem.inspectionDate!.year,
  //             notiitem.inspectionDate!.month,
  //             notiitem.inspectionDate!.day-i,
  //             notiitem.inspectionDate!.hour,
  //             notiitem.inspectionDate!.minute,
  //             notiitem.inspectionDate!.second,
  //             notiitem.inspectionDate!.microsecond);
  //         if (DateTime.now().compareTo(tempdate) <= 0) {
  //           final alarmsetting = new AlarmSettings(
  //             id: DateTime
  //                 .now()
  //                 .millisecondsSinceEpoch % 10000,
  //             dateTime: tempdate,
  //             assetAudioPath: 'assets/alarm-clock-01.mp3',
  //             notificationTitle: i==0?'แจ้งเตือนนัดพบ ': 'แจ้งเตือนร่วงหน้านัดพบ',
  //             notificationBody: 'แจ้งเตือนนัดพบแพทย์',
  //           );
  //           await Alarm.set(alarmSettings: alarmsetting);
  //         }
  //       }
  //     }
  //   }
  // }
}

// Main function to demonstrate login
// void main() async {
//   ApiService apiService = ApiService();
//   String username = 'yourUsername';
//   String password = 'yourPassword';
//
//   LoginResponseModel? loginResponse = await apiService.login(username, password);
//
//   if (loginResponse != null) {
//     print('Login successful: \${loginResponse.message}');
//     print('Token: \${loginResponse.token}');
//   } else {
//     print('Login failed');
//   }
// }
