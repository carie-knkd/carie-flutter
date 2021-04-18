import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationMap extends StatefulWidget {
  const LocationMap(
      {Key key,
      this.width,
      this.height,
      this.initLat = 10.76,
      this.initLng = 106.66})
      : super(key: key);
  final double width;
  final double height;
  final double initLat;
  final double initLng;
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  final HCMBaseLatLng = LatLng(10.76, 106.66);
  final lines = [
    new LatLng(10.76, 106.66),
    new LatLng(11.76, 107.66),
    new LatLng(12.76, 108.66),
    new LatLng(13.76, 109.66),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: widget.height - 500.0,
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
              // MarkerLayerOptions(
              //   markers: [
              //     Marker(
              //       width: 80.0,
              //       height: 80.0,
              //       point: LatLng(10.76, 106.66),
              //       builder: (ctx) => Container(
              //         child: Icon(
              //           Icons.location_on,
              //           color: kPrimaryColor,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              PolylineLayerOptions(polylines: [
                new Polyline(
                    points: lines, strokeWidth: 5.0, color: Colors.red),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
