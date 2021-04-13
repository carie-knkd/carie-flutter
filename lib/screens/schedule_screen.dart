import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/components/schedule_card.dart';
import 'package:flutter_go_app/model/Schedule.dart';
import 'package:flutter_go_app/screens/adding_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleScreenState();
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
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: MaterialButton(
                    child: Text(
                      "Thêm lịch",
                      style: TextStyle(color: Colors.white),
                    ),
                    splashColor: kPrimaryColor,
                    onPressed: () async {
                      print("SCHEDULE ADDED");
                      final Schedule schedule = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddingScheduleScreen()));
                      list.add(schedule);
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: height * 2 / 3.2,
          width: height / 2.3,
          child: list.length > 0
              ? ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        color: Colors.transparent,
                      ),
                  itemBuilder: (context, index) =>
                      ScheduleCard(schedule: list[index]))
              : Center(
                  child: Text("Chưa có lịch trình"),
                ),
        )
      ],
    ));
  }
}
