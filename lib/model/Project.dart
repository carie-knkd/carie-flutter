import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;
  final double lat;
  final double lng;

  Project(
      {@required this.id, this.name, @required this.lat, @required this.lng});

  factory Project.fromJson(Map json) => Project(
      id: json["_id"], name: json['name'], lat: json['lat'], lng: json['lng']);
}
