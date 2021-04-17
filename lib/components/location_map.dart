import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key key, this.width, this.height}) : super(key: key);
  final double width;
  final double height;
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Nhập vị trí"),
              ),
              Container(
                height: widget.height,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(10.76, 106.66),
                    zoom: 10.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(10.76, 106.66),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_on,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // PolylineLayerOptions(polylines: [new Polyline()]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
