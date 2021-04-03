import 'package:flutter/material.dart';

class Person {
  final String id;
  final String firstname;
  final String lastname;

  Person(
      {@required this.id, @required this.firstname, @required this.lastname});

  factory Person.fromJson(Map json) {
    return Person(
        id: json['_id'],
        firstname: json['firstname'],
        lastname: json['lastname']);
  }
}
