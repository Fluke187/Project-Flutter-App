import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddNoti.dart';
import 'Data/ApiService.dart';
import 'Models/NotiGetModel.dart';

class Doc1 extends StatefulWidget {
  const Doc1({super.key});

  @override
  State<Doc1> createState() => _Medh1State();
}

class _Medh1State extends State<Doc1> {
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
                  Container(
                    width: double.infinity,
                    // padding: const EdgeInsets.symmetric(
                    //     vertical: 30, horizontal: 20),
                    // color: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        // borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // const Icon(Icons.calendar_today, color: Colors.blue),
                          // const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator()) // Show loading indicator while fetching data
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
                                        borderRadius: BorderRadius.circular(
                                            12), // Rounded corners
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          var itmes = getNotiResponse
                                              ?.recordNoti?[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddDoctorPage(item: itmes),
                                            ),
                                          ).then((value) => setState(() {}));
                                        },
                                        borderRadius: BorderRadius.circular(
                                            12), // InkWell shape matches card's shape
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'วันที่:${noti.inspectionDate ?? null}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
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
                                    // Image.asset(
                                    //   'assets/K.png',
                                    //   height: 200,
                                    // ),
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
            } else
              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // children: <Widget>[
                  //   Text(
                  //     'กำลังโหลดข้อมูล',
                  //     style: TextStyle(fontSize: 24),
                  //     textAlign: TextAlign.center,
                  //   ),
                  //   SizedBox(
                  //     height: 50,
                  //   ),
                  //   CircularProgressIndicator(
                  //     semanticsLabel: 'Circular progress indicator',
                  //   ),
                  // ],
                ),
              );
          }),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDoctorPage()),
              ).then((value) => setState(() {}));
            },
            child: Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.lightBlueAccent,
          ),
        ),
      ),
    );
  }
}
