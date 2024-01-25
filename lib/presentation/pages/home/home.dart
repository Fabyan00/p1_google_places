import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p1_places_api/domain/places_usecase.dart';
import 'package:p1_places_api/presentation/bloc/place/place_bloc.dart';
import 'package:p1_places_api/presentation/pages/maps/components/place_details.dart';
import 'package:p1_places_api/presentation/pages/maps/maps.dart';
import 'package:p1_places_api/presentation/pages/maps/components/place_input_field.dart';
import 'package:p1_places_api/presentation/pages/shared/main_action_button.dart';
import 'package:p1_places_api/presentation/pages/shared/title_widget.dart';

class Home extends StatelessWidget {
  Home({super.key});

  PlacesUsecase placeUsecase = PlacesUsecase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        appBar: AppBar(
          backgroundColor: placeUsecase.mainColor,
          title: const TitleWidget(
            text: "Google Places API", 
            fontSize: 20,
          ),
        ),
        body: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) {
            _handleLocationState(context, state, placeUsecase);
          },
          builder: (context, state) {
            return Center(
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      PlaceInputField(placeUsecase: placeUsecase),
                      const SizedBox(height: 10),
                      PlaceDetails(placeUsecase: placeUsecase),
                      Maps(placeUsecase: placeUsecase),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: placeUsecase.mainColor,
          tooltip: "Current Location",
          child: const Icon(Icons.center_focus_strong_rounded),
          onPressed: () {
            if(placeUsecase.placeDesc.isNotEmpty){
              BlocProvider.of<PlaceBloc>(context).add(SetLoadingEvent());
              placeUsecase.determinePosition(context);
            }
          },
        ),
      )
    );
  }
}

void _handleLocationState(BuildContext context, PlaceState state, PlacesUsecase placeUsecase){
  if(state is LoadingState){
    placeUsecase.showAlert(
      context,
      const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: "Getting Location. . .", fontColor: Colors.black54,),
            SizedBox(height: 10,),
            CircularProgressIndicator(color: Colors.black54,),
          ],
        ),
      ),
    );
  }else if(state is SucceedSettingPlace){
    if(state.place == "here!"){
      Navigator.pop(context);
    }
    placeUsecase.setNewCoordinates(state);
    LatLng newLatLong = LatLng(placeUsecase.lat, placeUsecase.lon);
    placeUsecase.controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: newLatLong, zoom: placeUsecase.zoom)
      )
    );
    placeUsecase.place.clear();
  } else if(state is FailedSettingPlace){
     placeUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontSize: 20, fontColor: Colors.black54,),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Accept",
              action: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      )
    );
  }else if(state is FailedSettingUserLocation){
    placeUsecase.showAlert(
      context,
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWidget(text: state.message, fontSize: 20, fontColor: Colors.black54,),
            const SizedBox(height: 10,),
            MainActionButton(
              text: "Accept",
              action: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      )
    );
  }
} 
