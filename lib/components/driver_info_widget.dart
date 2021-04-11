import 'package:flutter/material.dart';
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
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text("Book this driver?"),
            content: Text(driver.toString()),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () => print("BOOKED"), child: Text("Book")),
              ),
            ],
          ));
}
