import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Data/ApiService.dart';
import 'Models/NotiGetModel.dart';

class liset extends StatefulWidget {
  const liset({super.key});

  @override
  State<liset> createState() => _Medh1State();
}

class _Medh1State extends State<liset> {
  bool isLoading = true;
  Notigetmodel? getNotiResponse;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> GetNoti() async {
    isLoading = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? Pid = prefs.getInt('Pid');
      if (Pid != null) {
        var response = await ApiService().GetNoti(Pid);
        getNotiResponse = response;
      } else {
        print('Error: userId not found');
      }
      isLoading = false;
      return true;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back button
        title: Text(
          'การนัดพบแพทย์',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
          future: GetNoti(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: isLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : getNotiResponse != null &&
                        getNotiResponse!.recordNoti!.isNotEmpty
                        ? ListView.builder(
                      itemCount: getNotiResponse!.recordNoti!.length,
                      itemBuilder: (context, index) {
                        var noti =
                        getNotiResponse!.recordNoti![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: Card(
                            elevation: 3, // Adds shadow to the card
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'วันที่: ${noti.inspectionDate ?? 'ไม่มีข้อมูล'}',
                                    style: const TextStyle(
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'ไม่พบรายการนัด',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'กำลังพยายามโหลดข้อมูล\nกรุณาตรวจสอบอินเตอร์เน็ต',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CircularProgressIndicator(
                      semanticsLabel: 'Circular progress indicator',
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
