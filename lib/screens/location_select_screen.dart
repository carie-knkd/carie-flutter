import 'package:flutter/material.dart';
import '../components/location_map.dart';

class LocationSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        child: LocationMap(
          width: size.width,
          height: size.height - 100.0,
        ),
      ),
    );
  }
}
