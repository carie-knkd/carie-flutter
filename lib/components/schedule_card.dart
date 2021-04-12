import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Schedule.dart';

// ignore: must_be_immutable
class ScheduleCard extends StatefulWidget {
  Schedule schedule;
  ScheduleCard({@required this.schedule});
  @override
  State<StatefulWidget> createState() => ScheduleCardState();
}

class ScheduleCardState extends State<ScheduleCard> {
  String parseFromList(List<bool> list) {
    String result = "";
    for (int i = 0; i < 7; i++) {
      if (list[i]) if (i != 6)
        result += (i + 2).toString() + ", ";
      else
        result += "CN, ";
    }
    return result.substring(0, result.length - 2);
  }

  String parseFromTimeOfDay(TimeOfDay t) {
    String result = "";

    if (t.hour < 10) result += "0";
    result += t.hour.toString();
    result += ":";
    if (t.minute < 10) result += "0";
    result += t.minute.toString();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Schedule schedule = widget.schedule;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: schedule.isEnabled ? kPrimaryColor : kUnhighlightedColor),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.fromLTRB(
          height * 0.02, height * 0.01, height * 0.01, height * 0.01),
      height: height / 5.5,
      width: height / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: height / 3.1,
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
              Switch(
                  activeColor: kPrimaryColor,
                  value: schedule.isEnabled,
                  onChanged: (value) {
                    setState(() {
                      schedule.isEnabled = value;
                    });
                  })
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
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
                      : kUnhighlightedColor),
            ),
          ),
          Text(
            "${parseFromTimeOfDay(schedule.from)} - ${parseFromTimeOfDay(schedule.to)}",
            style: TextStyle(
                fontSize: (height / 20),
                color: schedule.isEnabled ? Colors.black : kUnhighlightedColor),
          ),
        ],
      ),
    );
  }
}
