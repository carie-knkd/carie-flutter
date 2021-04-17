import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_go_app/model/Driver.dart';

class DriverInfoWidget extends StatelessWidget {
  final Driver driver;
  DriverInfoWidget({@required this.driver});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return GestureDetector(
        onTap: () {
          print("tapped");
          showDriverInfo(context, driver);
        },
        child: Transform.scale(
          scale: 1.1,
          child: Card(
              elevation: 5,
              // semanticContainer: true,
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Wrap(
                  children: [
                    Column(children: [
                      Image.asset(
                        'lib/images/empty-avatar.jpg',
                        scale: 1000 / height,
                      ),
                      Text(driver.lastname + " " + driver.firstname),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(driver.star.toString()),
                            Image.asset(
                              'lib/images/small-star.png',
                              scale: 5,
                            )
                          ],
                        ),
                      )
                    ])
                  ],
                ),
              )),
        ));
  }
}

void showDriverInfo(BuildContext context, Driver driver) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: height / 1.8,
              width: height / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: Image.asset(
                      'lib/images/empty-avatar.jpg',
                      scale: 510 / height,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: height / 8,
                    width: height / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.lastname + " " + driver.firstname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 40),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              driver.star.toString(),
                              style: TextStyle(fontSize: height / 60),
                            ),
                            Image.asset(
                              'lib/images/small-star.png',
                              scale: 4,
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: height / 9,
                              child: Text(
                                "5h-22h",
                              ),
                            ),
                            Container(
                              width: height / 5.2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "2,3,4,5,6",

                                //maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: height / 9,
                              child: Text(
                                "5h-22h",
                              ),
                            ),
                            Container(
                              width: height / 5.2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "7,CN",
                                //maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: height * 0.1,
                  // ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("BOOK TÀI XẾ"),
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ));
}
