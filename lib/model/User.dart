import 'package:flutter/cupertino.dart';
import 'package:flutter_go_app/model/Schedule.dart';

class User {
  String id;
  String phoneNumber;
  List<Schedule> scheduleList;

  User(
      {@required this.id,
      @required this.phoneNumber,
      @required this.scheduleList});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        phoneNumber: json['phonenumber'],
        scheduleList: json['schedulelist']);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> schedules =
        scheduleList.map((e) => e.toJson()).toList();
    return {'id': id, 'phonenumber': phoneNumber, 'schedulelist': schedules};
  }
}
