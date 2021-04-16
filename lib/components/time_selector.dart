import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';

class TimeSelector extends StatefulWidget {
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;
  final int hourOffset;
  final int minuteOffset;
  TimeSelector(
      {Key key,
      @required this.onHourChanged,
      @required this.onMinuteChanged,
      @required this.hourOffset,
      @required this.minuteOffset});

  @override
  TimeSelectorState createState() =>
      TimeSelectorState(hourOffset: hourOffset, minuteOffset: minuteOffset);
}

class TimeSelectorState extends State<TimeSelector> {
  int hour;
  int minute;
  int hourOffset;
  int minuteOffset;
  TimeSelectorState({@required this.hourOffset, @required this.minuteOffset}) {
    hour = hourOffset;
    minute = minuteOffset;
  }
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
                    hour = value + hourOffset;
                    widget.onHourChanged((value + hourOffset) % 24);
                  });
                },
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) => Text(
                      ((index + hourOffset) % 24 < 10)
                          ? "0${(index + hourOffset) % 24}"
                          : "${(index + hourOffset) % 24}",
                      style: TextStyle(
                          fontSize: height * 0.038,
                          color: (hour == index + hourOffset)
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
                    minute = value + minuteOffset;
                    widget.onMinuteChanged((value + minuteOffset) % 60);
                  });
                },
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) => Text(
                      ((index + minuteOffset) % 60 < 10)
                          ? "0${(index + minuteOffset) % 60}"
                          : "${(index + minuteOffset) % 60}",
                      style: TextStyle(
                          fontSize: height * 0.038,
                          color: (minute == index + minuteOffset)
                              ? kPrimaryColor
                              : kUnhighlightedColor)),
                ))),
      ],
    );
  }
}
