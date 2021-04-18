import 'package:flutter/material.dart';
import 'package:flutter_go_app/components/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationMap extends StatefulWidget {
  const LocationMap(
      {Key key, this.width, this.height, this.initLat, this.initLng})
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

  @override
  Widget build(BuildContext context) {
    final lines = [
      new LatLng(10.870988086855629, 106.77825484166709),
      new LatLng(widget.initLat, widget.initLng)
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: widget.height - 100.0,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(widget.initLat, widget.initLng),
              zoom: 18.0,
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
                    point: LatLng(widget.initLat, widget.initLng),
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
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
