import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p1_places_api/presentation/bloc/place/place_bloc.dart';
import 'package:p1_places_api/presentation/pages/shared/state_dialog.dart';

class PlacesUsecase{

  var mainColor = const Color.fromARGB(255, 241, 240, 240);

  final TextEditingController _place = TextEditingController();
  TextEditingController get place => _place;
  double lat = 19.394208;
  double lon = -99.028858;
  String placeDesc = "";
  double zoom = 15.0;

  late GoogleMapController controller;

  void setNewCoordinates(PlaceState state){
    if(state is SucceedSettingPlace){
      lat = state.lat;
      lon = state.lon;
      placeDesc = state.place;
    }
  }

  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location services are disabled.'));
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if(!context.mounted) return Future.error("No context"); 
        BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location permissions are denied.'));
        return Future.error('Location permissions are denied');
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. If not, you can use in app message to handle
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent('Location permissions are permanently denied, we cannot request permissions.'));
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 
    if(!context.mounted) return Future.error("No context"); 
    getUserLocation(context);
    return await Geolocator.getCurrentPosition();
  }

  void getUserLocation(BuildContext context) async {
    try{
      var position = await GeolocatorPlatform.instance.getCurrentPosition();
      if(!context.mounted) return Future.error("No context"); 
      BlocProvider.of<PlaceBloc>(context).add(SetPlaceEvent(position.latitude.toString(), position.longitude.toString(), "here!"));
    }catch(e){
      BlocProvider.of<PlaceBloc>(context).add(SetErrorLocationEvent("Couldn't get user's location, try again latter",));
    }
  
   
  }

  void showAlert(BuildContext context, Widget content) {
    showDialog(
      context: context,
      builder: (context) => StateDialog(
        content: content
      )
    );
  }
}