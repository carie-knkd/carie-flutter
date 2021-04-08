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

  String toString() {
    String id = "ID: " + this.id + "\n";
    String firstname = "ID: " + this.firstname + "\n";
    String lastname = "ID: " + this.lastname + "\n";
    String result = id + firstname + lastname;
    return result;
  }
}
