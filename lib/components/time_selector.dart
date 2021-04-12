import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';

class TimeSelector extends StatefulWidget {
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;
  TimeSelector(
      {Key key, @required this.onHourChanged, @required this.onMinuteChanged});

  @override
  TimeSelectorState createState() => TimeSelectorState();
}

class TimeSelectorState extends State<TimeSelector> {
  int hour = 0;
  int minute = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
            height: height / 4.5,
            width: height / 5.5,
            child: ListWheelScrollView.useDelegate(
                diameterRatio: 10,
                itemExtent: height / 13,
                onSelectedItemChanged: (value) {
                  setState(() {
                    hour = value;
                    widget.onHourChanged(value % 24);
                  });
                },
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) => Text(
                      (index % 24 < 10) ? "0${index % 24}" : "${index % 24}",
                      style: TextStyle(
                          fontSize: height * 0.038,
                          color: (hour == index)
                              ? kPrimaryColor
                              : kUnhighlightedColor)),
                ))),
        Container(
            height: height / 4.5,
            width: height / 5.5,
            child: ListWheelScrollView.useDelegate(
                diameterRatio: 10,
                itemExtent: height / 13,
                onSelectedItemChanged: (value) {
                  setState(() {
                    minute = value;
                    widget.onMinuteChanged(value % 60);
                  });
                },
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) => Text(
                      (index % 60 < 10) ? "0${index % 60}" : "${index % 60}",
                      style: TextStyle(
                          fontSize: height * 0.038,
                          color: (minute == index)
                              ? kPrimaryColor
                              : kUnhighlightedColor)),
                ))),
      ],
    );
  }
}
