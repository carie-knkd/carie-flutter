import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/date_selector.dart';
import 'package:flutter_go_app/screens/daily_screen.dart';
import 'package:flutter_go_app/screens/driver_choosing_screen.dart';
import 'package:flutter_go_app/components/location_map.dart';
import 'package:flutter_go_app/screens/phone_screen.dart';
import 'package:flutter_go_app/screens/schedule_screen.dart';

// Future<List<Person>> fetchData() async {
//   final response = await http.get(Uri.http('localhost:12345', '/person'));
//   if (response.statusCode == 200) {
//     return List<Person>.fromJson(jsonDecode(response.body));
//   } else
//     throw Exception('failed to load db');
// }

// Future<String> fetchData() async {
//   final response = await http.get(Uri.http('10.43.176.168:8000', '/person'));
//   print(JsonEncoder.withIndent('    ').convert(response));
//   PhoneNumber
//   return response.body;
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: ScheduleScreen()),
    );
  }
}
