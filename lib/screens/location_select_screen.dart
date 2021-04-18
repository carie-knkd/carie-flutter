import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Project.dart';
import 'package:flutter_go_app/model/Schedule.dart';
import '../components/location_map.dart';
import 'package:http/http.dart' as http;

class LocationSelectScreen extends StatefulWidget {
  LocationSelectScreen({this.project});
  final Project project;
  @override
  State<StatefulWidget> createState() => LocationSelectScreenState();
}

class LocationSelectScreenState extends State<LocationSelectScreen> {
  TextEditingController nameController = new TextEditingController(text: "");
  double initLat = 0.0;
  double initLng = 0.0;
  // LocationSelectScreenState({@required this.projectName})
  Future<Project> getProjectByName(String name) async {
    print("___________________________________________");
    var queryParameters = {
      'name': nameController.text,
    };
    var url = Uri.http("192.168.43.45:12345", "/location", queryParameters);
    print(url);
    final response = await http.get(url).timeout(
          Duration(seconds: 10),
        );

    final project = Project.fromJson(jsonDecode(response.body));
    setState(() {
      initLat = double.parse(project.lat);
      initLng = double.parse(project.lng);
    });
    print(initLat.toString() + " " + initLng.toString());
    return project;
  }

  // LocationSelectScreenState({
  //   // nameController = TextEditingController(text: );
  // })

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: size.width * 0.9,
            height: size.height - 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Nhập địa điểm"),
                  controller: nameController,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Project project =
                        await getProjectByName(nameController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationMap(
                                width: size.width,
                                height: size.height - 100.0,
                                initLat: double.parse(project.lat),
                                initLng: double.parse(project.lng))));
                  },
                  child: Text("Xác nhận"),
                ),
                // Container(
                //   width: size.width,
                //   height: size.height - 100.0,
                // child: FutureBuilder(
                //   future: getProjectByName(nameController.text),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError)
                //       print(snapshot.error);
                //     else if (snapshot.hasData) {
                //       return LocationMap(
                //           initLat: double.parse(snapshot.data.lat),
                //           initLng: double.parse(snapshot.data.lng),
                //           width: size.width,
                //           height: size.height);
                //     }
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
                // child: LocationMap(
                //   initLat: initLat,
                //   initLng: initLng,
                //   width: size.width,
                //   height: size.height,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
