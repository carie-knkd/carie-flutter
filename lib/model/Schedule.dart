import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_go_app/model/Time.dart';

class Schedule {
  String content;
  String description;
  Time pickTime;
  Time dropTime;
  List<bool> daysInWeek;
  bool isEnabled;
  DateTime from;
  DateTime to;
  Schedule(
      {@required this.content,
      @required this.description,
      @required this.pickTime,
      @required this.dropTime,
      @required this.daysInWeek,
      @required this.from,
      @required this.to,
      this.isEnabled = true});

  static Schedule fromJson(Map<String, dynamic> json) {
    String days = json['daysinweek'];
    List<bool> daysInWeek = [];
    for (int i = 0; i < 7; i++) {
      if (days[i] == '0')
        daysInWeek.add(false);
      else
        daysInWeek.add(true);
    }
    return Schedule(
        content: json['content'],
        description: json['description'],
        pickTime: Time.fromJson(json['picktime']),
        dropTime: Time.fromJson(json['droptime']),
        daysInWeek: daysInWeek,
        from: DateTime.parse(json['from']),
        to: DateTime.parse(json['to']),
        isEnabled: json['isenabled']);
  }

  Map<String, dynamic> toJson() {
    String days = "";
    for (bool b in daysInWeek) {
      if (b)
        days += '1';
      else
        days += '0';
    }
    return {
      'content': content,
      'description': description,
      'picktime': (pickTime.toJson()),
      'droptime': (dropTime.toJson()),
      'daysinweek': days,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'isenabled': isEnabled,
    };
  }
}
