import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => MapState();
}

class MapState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _genesysLocation = CameraPosition(
    target: LatLng(43.857805, -79.349803),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _genesysLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      gestureRecognizers: Set()
      ),
    );
  }
}