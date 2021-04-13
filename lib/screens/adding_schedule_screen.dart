import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/components/time_selector.dart';
import 'package:flutter_go_app/model/Schedule.dart';
import 'package:flutter_go_app/model/Time.dart';
import 'package:intl/intl.dart';

class AddingScheduleScreen extends StatefulWidget {
  final Schedule schedule;
  //AddingScheduleScreen();
  AddingScheduleScreen({this.schedule});
  @override
  State<StatefulWidget> createState() =>
      AddingScheduleScreenState(schedule: schedule);
}

class AddingScheduleScreenState extends State<AddingScheduleScreen> {
  TextEditingController content;
  TextEditingController description;
  int fromHour;
  int fromMinute;
  int toHour;
  int toMinute;
  DateTime from;
  DateTime to;
  List<bool> daysInWeek;
  Schedule schedule;

  AddingScheduleScreenState({@required this.schedule}) {
    if (schedule != null) {
      content = TextEditingController(text: schedule.content);
      description = TextEditingController(text: schedule.description);
      fromHour = schedule.pickTime.hour;
      fromMinute = schedule.pickTime.minute;
      toHour = schedule.dropTime.hour;
      toMinute = schedule.dropTime.minute;
      from = schedule.from;
      to = schedule.to;
      print(DateFormat('dd-MM-yyyy').format(from));
      daysInWeek = schedule.daysInWeek;
    } else {
      daysInWeek = List<bool>.filled(7, false);
      content = TextEditingController();
      description = TextEditingController();
      fromHour = fromMinute = toHour = toMinute = 0;
      from = DateTime.now();
      to = DateTime.now();
    }
  }

  Future<void> _selectDate(
      BuildContext context, DateTime selectedDate, bool isFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        if (isFrom)
          from = picked;
        else
          to = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<Container> buttons = List<Container>.generate(
        7,
        (index) => Container(
              padding: EdgeInsets.only(left: height / 130, right: height / 130),
              child: GestureDetector(
                onTap: () {
                  daysInWeek[index] = !(daysInWeek[index]);
                  setState(() {});
                },
                child: Container(
                    width: height / 22,
                    height: height / 22,
                    decoration: BoxDecoration(
                        color: daysInWeek[index]
                            ? kPrimaryColor
                            : Colors.transparent,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                            text: (index != 6) ? (index + 2).toString() : "CN"),
                        style: TextStyle(
                            color: daysInWeek[index]
                                ? Colors.white
                                : kPrimaryColor,
                            fontSize: height / 45),
                      ),
                    )),
              ),
            ));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  height * 0.03, height * 0.05, height * 0.03, height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      controller: content,
                      style: TextStyle(
                          fontSize: height * 0.04, color: kPrimaryColor),
                      decoration: InputDecoration(
                          hintText: "Nội dung",
                          hintStyle: TextStyle(color: kUnhighlightedColor),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)))),
                  Container(
                    padding: EdgeInsets.only(
                        top: height * 0.01, bottom: height * 0.03),
                    width: height / 3,
                    child: TextFormField(
                      controller: description,
                      style: TextStyle(
                          fontSize: height * 0.02, color: kSecondaryColor),
                      decoration: InputDecoration(
                          hintText: "Mô tả",
                          hintStyle: TextStyle(color: kUnhighlightedColor),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kSecondaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kSecondaryColor))),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buttons,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: height * 0.02, bottom: height * 0.02),
                        child: Text(
                          "Giờ đưa",
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                      ),
                      TimeSelector(
                        hourOffset: fromHour,
                        minuteOffset: fromMinute,
                        onHourChanged: (value) {
                          fromHour = value;
                        },
                        onMinuteChanged: (value) {
                          fromMinute = value;
                        },
                      )
                    ],
                  )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: Text(
                          "Giờ đón",
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                      ),
                      TimeSelector(
                        hourOffset: toHour,
                        minuteOffset: toMinute,
                        onHourChanged: (value) {
                          toHour = value;
                        },
                        onMinuteChanged: (value) {
                          toMinute = value;
                        },
                      ),
                    ],
                  )),
                ],
              ),
            ),
            // SizedBox(
            //   height: height * 0.01,
            // ),
            Container(
              height: height / 19,
              width: height / 2.7,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context, from, true),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        width: height * 0.4 / 2.7,
                        alignment: Alignment.center,
                        child:
                            Text("${DateFormat('dd-MM-yyyy').format(from)}")),
                  ),
                  Container(
                    width: height * 0.2 / 2.7,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 20.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, to, false),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        width: height * 0.4 / 2.7,
                        alignment: Alignment.center,
                        child: Text("${DateFormat('dd-MM-yyyy').format(to)}")),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              width: height / 4,
              height: height / 20,
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
              child: MaterialButton(
                splashColor: kPrimaryColor,
                onPressed: () {
                  if (content.text.length == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                            title: Text("Hãy nhập nội dung lịch trình")));
                    return;
                  }
                  if (description.text.length == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                            title: Text("Hãy nhập mô tả lịch trình")));
                    return;
                  }
                  bool atLeastOne = false;
                  for (int i = 0; i < 7; i++) {
                    if (daysInWeek[i]) {
                      atLeastOne = true;
                      break;
                    }
                  }
                  if (!atLeastOne) {
                    showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                            title: Text("Hãy chọn ít nhất một ngày")));
                    return;
                  }
                  if (to.isBefore(from)) {
                    showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                            title: Text("Hãy chọn ngày hợp lệ")));
                    return;
                  }
                  schedule = Schedule(
                      content: content.text,
                      description: description.text,
                      pickTime: Time(hour: fromHour, minute: fromMinute),
                      dropTime: Time(hour: toHour, minute: toMinute),
                      daysInWeek: daysInWeek,
                      from: from,
                      to: to);
                  Navigator.pop(context, schedule);
                },
                child: Text(
                  "Tạo lịch",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
