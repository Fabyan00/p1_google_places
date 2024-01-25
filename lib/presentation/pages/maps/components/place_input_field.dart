import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:p1_places_api/domain/places_usecase.dart';
import 'package:p1_places_api/presentation/bloc/place/place_bloc.dart';

class PlaceInputField extends StatelessWidget {
  PlaceInputField({
    super.key,
    required this.placeUsecase
  });

  PlacesUsecase placeUsecase;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,  horizontal: 10),
      width: double.maxFinite,
      height: 50,
      child: GooglePlaceAutoCompleteTextField(
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: placeUsecase.mainColor
        ),
        textEditingController: placeUsecase.place, 
        
        googleAPIKey: "AIzaSyC3R8yAWNMR_uIh-aiPLeFiH3WNyoPeaok",
        inputDecoration: InputDecoration(
          hintText: "Where to 🗺",
          hintStyle: GoogleFonts.raleway(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.grey
            )  
          ),
          border: InputBorder.none,
        ),
        getPlaceDetailWithLatLng: (Prediction prediction) {
          try{
            BlocProvider.of<PlaceBloc>(context).add(SetPlaceEvent(prediction.lat!, prediction.lng!, prediction.description!));
          }catch(e){
            BlocProvider.of<PlaceBloc>(context).add(SetErrorPlaceEvent("Something went wrong! Couldn't reach the place. Try again latter", ""));
          }
        },
        itemClick: (Prediction prediction) {},
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 7,
                ),
                Expanded(child: Text(prediction.description??""))
              ],
            ),
          );
        },
        isCrossBtnShown: true,
      )
    );
  }
}