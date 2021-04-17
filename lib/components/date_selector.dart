import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final DateTime initialDate;
  final DateTime currentDate;
  final ValueChanged<DateTime> onDateSelectedChanged;
  DateSelector(
      {@required this.initialDate,
      @required this.currentDate,
      @required this.onDateSelectedChanged}) {
    print(initialDate);
  }
  @override
  State<StatefulWidget> createState() => DateSelectorState();
}

class DateSelectorState extends State<DateSelector> {
  int selectedIndex;
  DateTime selectedDate = DateTime.now();
  String date;
  String weekday;
  PageController controller;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.currentDate;
    selectedIndex = widget.initialDate.difference(selectedDate).inDays;
    print("initing");
    controller = PageController(
        viewportFraction: 0.33, keepPage: true, initialPage: selectedIndex);
  }

  Map<String, String> daysInVNmese = {
    'Monday': 'Hai',
    'Tuesday': 'Ba',
    'Wednesday': 'Tư',
    'Thursday': 'Năm',
    'Friday': 'Sáu',
    'Saturday': 'Bảy',
    'Sunday': 'CN'
  };
  @override
  Widget build(BuildContext context) {
    //print(controller.initialPage);
    double height = MediaQuery.of(context).size.height;
    return Container(
        // width: width * 0.7,
        height: height / 5,
        //decoration: BoxDecoration(border: Border.all(color: kPrimaryColor)),
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => controller.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: index == selectedIndex
                        ? kPrimaryColor
                        : Colors.transparent),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          daysInVNmese[DateFormat('EEEE')
                              .format(selectedDate.add(Duration(days: index)))],
                          style: TextStyle(
                              fontSize: 20,
                              color: index == selectedIndex
                                  ? Colors.white
                                  : kUnhighlightedColor),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        DateFormat('dd-MM')
                            .format(selectedDate.add(Duration(days: index))),
                        style: TextStyle(
                            fontSize: 30,
                            color: index == selectedIndex
                                ? Colors.white
                                : kPrimaryColor),
                      ),
                    )
                  ],
                ),
              )),
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
              widget.onDateSelectedChanged(
                  selectedDate.add(Duration(days: index)));
            });
            print("$index");
          },
          //pageSnapping: true,
        ));
  }
}
