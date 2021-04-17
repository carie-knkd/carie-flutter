import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/model/User.dart';
import 'package:flutter_go_app/screens/daily_screen.dart';
import 'package:flutter_go_app/screens/driver_choosing_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/components/schedule_card.dart';
import 'package:flutter_go_app/model/Schedule.dart';
import 'package:flutter_go_app/screens/adding_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleScreenState();
}

Future<http.Response> addUser(User user) async {
  final response = await http.post(Uri.http("172.16.4.85:8080", "/person"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(user.toJson()));
  return response;
}

class ScheduleScreenState extends State<ScheduleScreen> {
  List<Schedule> list = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 50, 30, 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lịch trình",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: height / 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    "Con cần đưa đón vào thời gian",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: height / 40,
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: Text(
                    "Thêm lịch",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      minimumSize: Size(height / 10, height / 20)),
                  onPressed: () async {
                    print("SCHEDULE ADDED");
                    final Schedule schedule = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddingScheduleScreen()));
                    if (schedule != null)
                      setState(() {
                        list.add(schedule);
                      });
                  },
                ),
              )
            ],
          ),
        ),
        Container(
            height: height / 1.9,
            width: height / 2.3,
            child: list.length > 0
                ? ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          color: Colors.transparent,
                        ),
                    itemBuilder: (context, index) => ScheduleCard(
                          schedule: list[index],
                          onScheduleChange: (value) {
                            setState(() {
                              list[index] = value;
                            });
                          },
                        ))
                : Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Chưa có lịch trình",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
        SizedBox(
          height: height / 20,
        ),
        Container(
          child: list.length == 0
              ? null
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      minimumSize: Size(height / 8, height / 20)),
                  onPressed: () async {
                    User user = User(
                        id: '1', phoneNumber: '0987532942', scheduleList: list);
                    //print((user.toJson()));
                    print(json.encode(user.toJson()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyScreen(),
                            settings: RouteSettings(arguments: list)));
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => Dialog(
                    //           child: FutureBuilder(
                    //             future: addUser(user),
                    //             builder: (context, snapshot) {
                    //               if (snapshot.hasData)
                    //                 return snapshot.data;
                    //               else if (snapshot.hasError)
                    //                 return Text("${snapshot.error}");
                    //               return CircularProgressIndicator();
                    //             },
                    //           ),
                    //         ));
                  },
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        )
      ],
    ));
  }
}
