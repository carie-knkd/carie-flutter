import 'package:flutter/material.dart';
import '../components/location_map.dart';

class LocationSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: LocationMap(
          height: MediaQuery.of(context).size.height - 20.0,
          width: MediaQuery.of(context).size.height - 20.0,
        ),
      ),
    );
  }
}
