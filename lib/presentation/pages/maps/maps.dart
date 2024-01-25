import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p1_places_api/domain/places_usecase.dart';

class Maps extends StatelessWidget {
  const Maps({super.key, required this.placeUsecase});
  final PlacesUsecase placeUsecase;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 500,
      child: GoogleMap(
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(
          target: LatLng(placeUsecase.lat, placeUsecase.lon),
          zoom: placeUsecase.zoom,
        ),
        onMapCreated: (GoogleMapController controller) {
          placeUsecase.controller = controller;
        },
        markers: {
          placeUsecase.placeDesc.isNotEmpty ? Marker(
            markerId: MarkerId(placeUsecase.placeDesc),
            position: LatLng(placeUsecase.lat, placeUsecase.lon),
            draggable: true,
            onDragEnd: null,
            infoWindow: InfoWindow(
              title: "(${placeUsecase.lat.toStringAsFixed(2)}, ${placeUsecase.lat.toStringAsFixed(2)})",
              onTap: () {},
            )
          ) : Marker(markerId: MarkerId("")),
        },
      ),
    );
  }
}
