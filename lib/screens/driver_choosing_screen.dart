import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_go_app/model/Person.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Driver.dart';
import 'package:flutter_go_app/components/driver_info_widget.dart';
import 'package:flutter_go_app/components/constants.dart';

class DriverChoosingScreen extends StatefulWidget {
  DriverChoosingScreen();
  @override
  State<DriverChoosingScreen> createState() => DriverChoosingScreenState();
}

void listDrivers() async {
  final url = 'http://$publicIP:12345/person';
  print(url);
  final client = new HttpClient();
  final request =
      await client.getUrl(Uri.parse(url)).timeout(Duration(seconds: 10));
  final response = await request.close();
  print(response.statusCode);
  print(response.contentLength);
  // Iterable l = json.decode(response.body);
  // List<Person> list =
  //     List<Driver>.from(l.map((e) => Driver.fromJson(e)).toList());
  // return list;
  // return null;
}

class DriverChoosingScreenState extends State<DriverChoosingScreen> {
  List<Driver> drivers = List<Driver>.generate(
      10, (i) => Driver("ID$i", "Firstname$i", "Lastname$i", 5));
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          SizedBox(
            height: height / 11,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () => listDrivers(),
                  child: Text("List Drivers"),
                ),
                Text(
                  "Xin chào bla bla",
                  style: TextStyle(
                      fontSize: height / 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: height / 45,
                ),
                Text(
                    "Đây là danh sách các tài xế \nphù hợp với nhu cầu của bạn",
                    style:
                        TextStyle(fontSize: height / 45, color: kPrimaryColor))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: height * 0.69,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: drivers.length,
              itemBuilder: (context, index) => Column(
                children: [DriverInfoWidget(drivers[index])],
              ),
            ),
            // child: FutureBuilder(
            //   future: listDrivers(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError)
            //       print(
            //         snapshot.error,
            //       );
            //     else if (snapshot.hasData) {
            //       List<Person> list = snapshot.data;
            //       return GridView.builder(
            //         scrollDirection: Axis.vertical,
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2),
            //         itemCount: list.length,
            //         itemBuilder: (context, index) => Column(
            //           children: [DriverInfoWidget(list[index])],
            //         ),
            //       );
            //     }
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // ),
          ),
        ]));
  }
}
