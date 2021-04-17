import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';

import 'package:flutter_go_app/model/Schedule.dart';

class TimetableCard extends StatefulWidget {
  final Schedule schedule;

  TimetableCard({@required this.schedule});
  Schedule getSchedule() => schedule;
  @override
  State<StatefulWidget> createState() => TimetableCardState();
}

class TimetableCardState extends State<TimetableCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          //decoration: BoxDecoration(border: Border.all(color: kPrimaryColor)),
          width: width * 0.9,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    widget.schedule.pickTime.toString(),
                    style: TextStyle(color: kUnhighlightedColor, fontSize: 18),
                  ),
                  Container(
                      width: width * 0.2,
                      height: 30,
                      alignment: Alignment.center,
                      child: VerticalDivider(
                        color: kUnhighlightedColor,
                        width: 5,
                        thickness: 2,
                      )),
                  Text(
                    widget.schedule.dropTime.toString(),
                    style: TextStyle(color: kUnhighlightedColor, fontSize: 18),
                  )
                ],
              ),
              Container(
                  width: width * 0.6,
                  height: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.schedule.content,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        widget.schedule.description,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
