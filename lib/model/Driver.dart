import 'package:flutter_go_app/model/Person.dart';

class Driver extends Person {
  final double star;
  Driver(String id, String firstname, String lastname, this.star)
      : super(id: id, firstname: firstname, lastname: lastname);

  static Driver fromJson(Map json) {
    return Driver(json['id'], json['firstname'], json['lastname'], 5);
  }

  @override
  String toString() {
    String basic = super.toString();
    String star = "Star: ${this.star}\n";
    String result = basic + star;
    return result;
  }
}
