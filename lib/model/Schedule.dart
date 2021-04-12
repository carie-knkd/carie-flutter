import 'package:flutter/material.dart';

class Schedule {
  String content;
  String description;
  TimeOfDay from;
  TimeOfDay to;
  List<bool> daysInWeek;
  bool isEnabled;
  Schedule(
      {@required this.content,
      @required this.description,
      @required this.from,
      @required this.to,
      @required this.daysInWeek,
      this.isEnabled = true});
}
