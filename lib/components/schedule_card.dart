import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Schedule.dart';
import 'package:flutter_go_app/screens/adding_schedule_screen.dart';
import 'package:flutter_go_app/model/Time.dart';

// ignore: must_be_immutable
class ScheduleCard extends StatefulWidget {
  Schedule schedule;
  final ValueChanged<Schedule> onScheduleChange;
  ScheduleCard({@required this.onScheduleChange, @required this.schedule});
  @override
  State<StatefulWidget> createState() => ScheduleCardState();
}

class ScheduleCardState extends State<ScheduleCard> {
  String parseFromList(List<bool> list) {
    String result = "";
    bool everyday = true;
    for (int i = 0; i < 7; i++) {
      if (list[i]) {
        if (i != 6)
          result += (i + 2).toString() + ", ";
        else
          result += "CN, ";
      } else
        everyday = false;
    }

    return everyday ? "Mỗi ngày" : result.substring(0, result.length - 2);
  }

  String parseFromTime(Time t) {
    String result = "";

    if ((t.hour) < 10) result += "0";
    result += t.hour.toString();
    result += ":";
    if ((t.minute) < 10) result += "0";
    result += t.minute.toString();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Schedule schedule = widget.schedule;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        final Schedule schedule = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddingScheduleScreen(
                      schedule: widget.schedule,
                    )));
        widget.onScheduleChange(schedule);
        widget.schedule = schedule;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    schedule.isEnabled ? kPrimaryColor : kUnhighlightedColor),
            borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.fromLTRB(
            height * 0.02, height * 0.01, height * 0.01, height * 0.01),
        height: height / 5.5,
        width: width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: width * 0.62,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: schedule.content,
                        style: TextStyle(
                            color: schedule.isEnabled
                                ? kPrimaryColor
                                : kUnhighlightedColor,
                            fontSize: height / 40)),
                    TextSpan(
                      text: '\n' + schedule.description,
                      style: TextStyle(
                          color: schedule.isEnabled
                              ? Colors.black
                              : kUnhighlightedColor,
                          fontSize: height / 60),
                    )
                  ])),
                ),
                Container(
                  width: width * 0.2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                        activeColor: kPrimaryColor,
                        value: schedule.isEnabled,
                        onChanged: (value) {
                          setState(() {
                            schedule.isEnabled = value;
                          });
                        }),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: schedule.isEnabled
                          ? kSecondaryColor
                          : kUnhighlightedColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                parseFromList(schedule.daysInWeek),
                style: TextStyle(
                    color: schedule.isEnabled
                        ? kSecondaryColor
                        : kUnhighlightedColor,
                    fontSize: height / 70),
              ),
            ),
            Text(
              "${parseFromTime(schedule.pickTime)} - ${parseFromTime(schedule.dropTime)}",
              style: TextStyle(
                  fontSize: (width / 10),
                  color:
                      schedule.isEnabled ? Colors.black : kUnhighlightedColor),
            ),
          ],
        ),
      ),
    );
  }
}
