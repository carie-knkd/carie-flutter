import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
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

// Future<List<Person>> fetchData() async {
//   final response = await http.get(Uri.http('localhost:12345', '/person'));
//   if (response.statusCode == 200) {
//     return List<Person>.fromJson(jsonDecode(response.body));
//   } else
//     throw Exception('failed to load db');
// }

Future<String> fetchData() async {
  final response = await http.get(Uri.https('localhost:12345', '/get'));
  return response.body;
}

void main() {
  runApp(MaterialApp(home: Center(child: FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData)
        return Text('Data : ${snapshot.data}');
      else if (snapshot.hasError)
        return Text('ERROR!');
      else
        return CircularProgressIndicator();
    },
  ))));
  // runApp(MaterialApp(
  //   home: Center(
  //     child: Text('Hello'),
  //   ),
  // ));
}
