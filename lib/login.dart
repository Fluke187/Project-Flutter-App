import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectlasttt/Register1.dart';
import 'package:projectlasttt/permission.dart';
import 'Data/ApiService.dart';
import 'package:projectlasttt/OTP.dart';
import 'package:projectlasttt/OTP1.dart';
import 'package:projectlasttt/OTP2.dart';
import 'package:shared_preferences/shared_preferences.dart'; // นำเข้า SharedPreferences
import 'manu.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Alarm.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      AlarmPermissions.checkAndroidNotificationPermission();
      AlarmPermissions.checkAndroidScheduleExactAlarmPermission();
    }
    _loadSavedData();
    Alarm.stopAll();
  }

  _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('remember_me', _rememberMe);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.setBool('remember_me', false);
    }
    var acer=prefs.getInt("userId");
    acer=prefs.getInt("userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAFAFA),
      body: Center(
        child: SingleChildScrollView(  // ใช้ SingleChildScrollView ที่นี่
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/image/0001.png'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Pregnancy Tracker',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40.0),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'ชื่อผู้ใช้งาน',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'รหัสผ่าน',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'จดจำรหัสผ่าน',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 115,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          ApiService apiService = ApiService();
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          var responsedata = await apiService.login(username, password);
                          if (responsedata?.user?.id != null && responsedata?.user?.id != 0) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt("userId", responsedata!.user!.id!);
                            prefs.setInt("week", responsedata.week??0);
                            prefs.setInt("days", responsedata.days??0);
                            prefs.setInt("Pid", responsedata.pid??0);
                            _saveData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('ล็อคอินผิดพลาด')),
                            );
                          }
                        },
                        child: Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(fontSize: 15.0, color: Colors.white), // เปลี่ยนสีข้อความที่นี่
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    SizedBox(
                      width: 115,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Re1()),
                          );
                        },
                        child: Text(
                          'สมัครสมาชิก',
                            style: TextStyle(fontSize: 15.0, color: Colors.white), // เปลี่ยนสีข้อความที่นี่
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
