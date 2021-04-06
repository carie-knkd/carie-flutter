import 'package:international_phone_input/international_phone_input.dart';
import 'consumer_choosing_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // final TextEditingController controller = TextEditingController();
    // PhoneNumber number = PhoneNumber(isoCode: 'VN');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: BoxDecoration(color: kPrimaryColor),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 10,
                    ),
                    Text(
                      "CARIE",
                      style:
                          TextStyle(fontSize: height / 10, color: Colors.white),
                    ),
                    SizedBox(
                      height: height * 2 / 15,
                    ),
                    Transform.scale(
                        scale: 0.95,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Transform.scale(
                                scale: 0.90,
                                child: InternationalPhoneInput(
                                  border: InputBorder.none,
                                  onPhoneNumberChange: onPhoneNumberChange,
                                  initialPhoneNumber: phoneNumber,
                                  initialSelection: phoneIsoCode,
                                  enabledCountries: ['+84'],
                                  labelText: "Phone Number",
                                ),
                              )),
                        )),
                    SizedBox(
                      height: height / 20,
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConsumerChoosingScreen())),
                          child: Text("Tiếp tục",
                              style: TextStyle(
                                color: kPrimaryColor,
                              ))),
                    )
                  ],
                ),
              )
            ],
          ),
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
