import 'package:flutter/cupertino.dart';

class Time {
  int hour;
  int minute;

  Time({@required this.hour, @required this.minute});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(hour: json['hour'], minute: json['minute']);
  }

  Map<String, dynamic> toJson() => {'hour': hour, 'minute': minute};

  String toString() {
    return (hour < 10 ? "0" : "") +
        hour.toString() +
        ":" +
        (minute < 10 ? "0" : "") +
        minute.toString();
  }
}
