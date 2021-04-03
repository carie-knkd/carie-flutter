import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Future<List<Person>> fetchData() async {
//   final response = await http.get(Uri.http('localhost:12345', '/person'));
//   if (response.statusCode == 200) {
//     return List<Person>.fromJson(jsonDecode(response.body));
//   } else
//     throw Exception('failed to load db');
// }

Future<String> fetchData() async {
  final response = await http.get(Uri.https('localhost:12345', '/person'));
  print(JsonEncoder.withIndent('    ').convert(response));
  return response.body;
}

void main() {
  runApp(MaterialApp(
      home: Center(
          child: FutureBuilder(
    future: fetchData(),
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
