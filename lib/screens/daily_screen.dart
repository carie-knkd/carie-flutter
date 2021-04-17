import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/date_selector.dart';
import 'package:flutter_go_app/components/timetable_card.dart';
import 'package:flutter_go_app/model/Schedule.dart';
import 'package:flutter_go_app/model/User.dart';
import 'package:intl/intl.dart';

class DailyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DailyScreenState();
}

class DailyScreenState extends State<DailyScreen> {
  List<Schedule> list;
  DateTime currentDay = DateTime.now();

  Map<String, int> daysIndex = {
    'Monday': 0,
    'Tuesday': 1,
    'Wednesday': 2,
    'Thursday': 3,
    'Friday': 4,
    'Saturday': 5,
    'Sunday': 6
  };
  @override
  Widget build(BuildContext context) {
    List<TimetableCard> listCards = [];
    User user = ModalRoute.of(context).settings.arguments;
    list = user.scheduleList;

    for (Schedule s in list) {
      if (s.daysInWeek[daysIndex[DateFormat('EEEE').format(currentDay)]] &&
          s.from.isBefore(currentDay) &&
          currentDay.isBefore(s.to.add(Duration(days: 1)))) {
        listCards.add(TimetableCard(schedule: s));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
          children: [
            DateSelector(
              currentDate: currentDay.subtract(Duration(days: 365)),
              initialDate: currentDay,
              onDateSelectedChanged: (value) {
                setState(() {
                  currentDay = value;
                });
              },
            ),
            Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(children: listCards))
          ],
        ),
      ),
    );
  }
}
