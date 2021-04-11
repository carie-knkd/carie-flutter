import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Driver.dart';

class DriverInfoWidget extends StatelessWidget {
  final Driver driver;
  DriverInfoWidget(this.driver);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
        height: height / 5,
        width: width / 2.2,
        child: GestureDetector(
          onTap: () {
            print("tapped");
            showDriverInfo(context, driver);
          },
          child: Card(
            child: Wrap(
              children: [
                Column(children: [
                  Center(child: Text("INSERT PICTURE")),
                  Center(
                      child: Text(driver.firstname + "\n" + driver.lastname)),
                ])
              ],
            ),
          ),
        ));
  }
}

void showDriverInfo(BuildContext context, Driver driver) {
  double height = MediaQuery.of(context).size.height;
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: height / 2,
              width: height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/images/empty-avatar.jpg',
                    scale: 750 / height,
                  ),
                  ElevatedButton(
                    onPressed: () => print("BOOK"),
                    child: Text("BOOK TÀI XẾ"),
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ));
}
