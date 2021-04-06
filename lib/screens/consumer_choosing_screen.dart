import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';

class ConsumerChoosingScreen extends StatefulWidget {
  ConsumerChoosingScreen();
  @override
  ConsumerChoosingScreenState createState() => ConsumerChoosingScreenState();
}

class ConsumerChoosingScreenState extends State<ConsumerChoosingScreen> {
  bool isFirstTime = true;
  bool isTeenChosen = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 40, 0, 0),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(height: height / 20),
          Center(
            child: Text(
              "CARIE",
              style: TextStyle(fontSize: height / 10, color: kPrimaryColor),
            ),
          ),
          SizedBox(height: height / 8),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 40),
            child: Text(
              "Bạn cần đưa đón trẻ",
              style: TextStyle(color: kPrimaryColor, fontSize: 18),
            ),
          ),
          Center(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: (isTeenChosen || isFirstTime)
                              ? Colors.transparent
                              : kPrimaryColor,
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                          height: height / 4,
                          width: height / 5,
                          child: Center(
                            child: Text("5 - 10 tuổi",
                                style: TextStyle(
                                    color: (isTeenChosen || isFirstTime)
                                        ? kPrimaryColor
                                        : Colors.white,
                                    fontSize: 15)),
                          )),
                    ),
                    onTap: () {
                      isFirstTime = false;
                      isTeenChosen = false;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: height / 30,
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: (!isTeenChosen || isFirstTime)
                              ? Colors.transparent
                              : kPrimaryColor,
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                          height: height / 4,
                          width: height / 5,
                          child: Center(
                            child: Text("11-16 tuổi",
                                style: TextStyle(
                                    color: (!isTeenChosen || isFirstTime)
                                        ? kPrimaryColor
                                        : Colors.white,
                                    fontSize: 15)),
                          )),
                    ),
                    onTap: () {
                      isFirstTime = false;
                      isTeenChosen = true;
                      setState(() {});
                    },
                  )
                ],
              ),
              SizedBox(
                height: height / 15,
              ),
              Container(
                child: isFirstTime
                    ? null
                    : Transform.scale(
                        scale: 1.2,
                        child: MaterialButton(
                            onPressed: () => print("Button"),
                            child: Text("Tiếp tục",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                ))),
                      ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
