import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_go_app/model/Schedule.dart';

class User {
  String phoneNumber;
  List<Schedule> scheduleList;

  User({@required this.phoneNumber, @required this.scheduleList});

  static User fromJson(Map<String, dynamic> json) {
    Iterable l = json['schedulelist'];

    List<Schedule> schedules =
        List<Schedule>.from(l.map((e) => Schedule.fromJson(e)).toList());

    return User(phoneNumber: json['phonenumber'], scheduleList: schedules);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> schedules =
        scheduleList.map((e) => e.toJson()).toList();
    return {'phonenumber': phoneNumber, 'schedulelist': schedules};
  }
}
