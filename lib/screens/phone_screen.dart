import 'consumer_choosing_screen.dart';
import 'package:flutter_go_app/components/phone_input.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  PhoneScreen();
  @override
  PhoneScreenSstate createState() => PhoneScreenSstate();
}

class PhoneScreenSstate extends State<PhoneScreen> {
  String phoneNumber;
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

  bool isKeyBoardOn() {
    return MediaQuery.of(context).viewInsets.bottom != 0;
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
                  Container(
                    child: isKeyBoardOn()
                        ? null
                        : Text(
                            "CARIE",
                            style: TextStyle(
                                fontSize: height / 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    height: height * 2 / 15,
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
                    onPhoneNumberTyped: (value) {
                      setState(() {
                        isEnough = value;
                        print(isEnough);
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Container(
                    child: isKeyBoardOn()
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: kSecondaryColor),
                            //splashColor: kPrimaryColor,
                            onPressed: isEnough
                                ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConsumerChoosingScreen()))
                                : null,
                            child: Text(
                              "Tiếp tục",
                              style: TextStyle(
                                  color: isEnough
                                      ? Colors.white
                                      : kUnhighlightedColor),
                            ))
                        : null)),
          ],
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
