import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Time {
  int hour;
  int minute;

  Time({@required this.hour, @required this.minute});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
        hour: int.parse(json['hour']), minute: int.parse(json['minute']));
  }

  Map<String, dynamic> toJson() =>
      {'hour': hour.toString(), 'minute': minute.toString()};

  String toString() {
    return (hour < 10 ? "0" : "") +
        hour.toString() +
        ":" +
        (minute < 10 ? "0" : "") +
        minute.toString();
  }
}
