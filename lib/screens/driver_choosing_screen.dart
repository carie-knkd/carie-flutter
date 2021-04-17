import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_go_app/model/Person.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Driver.dart';
import 'package:flutter_go_app/components/driver_info_card.dart';

class DriverChoosingScreen extends StatefulWidget {
  DriverChoosingScreen();
  @override
  State<DriverChoosingScreen> createState() => DriverChoosingScreenState();
}

Future<List<Driver>> listDrivers() async {
  final url = '192.168.88.8:12345';
  final response = await http.get(Uri.http(url, "/person"));
  Iterable l = json.decode(response.body);

  List<Person> list =
      List<Driver>.from(l.map((e) => Driver.fromJson(e)).toList());
  return list;
  //return null;
}

class DriverChoosingScreenState extends State<DriverChoosingScreen> {
  Random random = new Random();
  List<Driver> drivers;
  @override
  Widget build(BuildContext context) {
    drivers = List<Driver>.generate(
        10,
        (i) => Driver("ID$i", "${String.fromCharCode(i + 65)}", "Nguyen Van",
            random.nextInt(10) / 10 + 4));
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
                Text(
                  "Xin chào Huy",
                  style: TextStyle(
                      fontSize: height / 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: height / 45,
                ),
                Text("Đây là danh sách các tài xế\nphù hợp với nhu cầu của bạn",
                    style:
                        TextStyle(fontSize: height / 45, color: kPrimaryColor))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(height / 180, 0, height / 180, 0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: height * 0.69,
            // child: GridView.builder(
            //   scrollDirection: Axis.vertical,
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2, mainAxisSpacing: height / 30),
            //   itemCount: drivers.length,
            //   itemBuilder: (context, index) => Column(
            //     children: [DriverInfoWidget(driver: drivers[index])],
            //   ),
            // ),
            child: FutureBuilder(
              future: listDrivers(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  print(
                    snapshot.error,
                  );
                else if (snapshot.hasData) {
                  List<Driver> list = snapshot.data;
                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisSpacing: 30),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Column(
                      children: [DriverInfoWidget(driver: list[index])],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ]));
  }
}
