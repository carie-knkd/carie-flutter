import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_go_app/model/User.dart';
import 'package:flutter_go_app/screens/daily_screen.dart';

import 'consumer_choosing_screen.dart';
import 'package:flutter_go_app/components/phone_input.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhoneScreen extends StatefulWidget {
  PhoneScreen();
  @override
  PhoneScreenSstate createState() => PhoneScreenSstate();
}

class PhoneScreenSstate extends State<PhoneScreen> {
  String phoneNumber = "";
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  bool isEnough = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(color: Colors.black)),
              height: height,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: height / 10,
                  ),
                  Text(
                    "CARIE",
                    style: TextStyle(
                        fontSize: height / 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height / 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Xin chào\n",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height / 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Số điện thoại của bạn là",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height / 40,
                              ),
                            )
                          ],
                        )),
                  ),
                  PhoneInput(
                    onPhoneNumberTyped: (String value) {
                      setState(() {
                        isEnough = value.length > 8;
                        phoneNumber = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Container(
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: kSecondaryColor),
                        //splashColor: kPrimaryColor,
                        onPressed: isEnough
                            ? () async {
                                print(MediaQuery.of(context).viewInsets.bottom);
                                Map<String, String> id = {
                                  "phone": phoneNumber,
                                };

                                final response = await http
                                    .get(Uri.http(publicIP, "/user", id));
                                if (response.body ==
                                    '{message: mongo: no documents in result }') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConsumerChoosingScreen(),
                                          settings: RouteSettings(
                                              arguments: phoneNumber)));
                                } else {
                                  print(response.body);
                                  print(jsonDecode(response.body));
                                  print("ok till here");
                                  User user =
                                      User.fromJson(jsonDecode(response.body));

                                  print(response.statusCode);
                                  if (response.statusCode == 200) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DailyScreen(),
                                            settings: RouteSettings(
                                                arguments: user)));
                                  } else
                                    throw new Exception(
                                        "Cant load user at phone screen");
                                }
                              }
                            : null,
                        child: Text(
                          "Tiếp tục",
                          style: TextStyle(
                              color: isEnough
                                  ? Colors.white
                                  : kUnhighlightedColor),
                        )))),
          ],
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
