import 'package:flutter/material.dart';
import 'package:p1_places_api/domain/places_usecase.dart';
import 'package:p1_places_api/presentation/pages/maps/components/location_button.dart';
import 'package:p1_places_api/presentation/pages/shared/body_widget.dart';
import 'package:p1_places_api/presentation/pages/shared/title_widget.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.placeUsecase});

  final PlacesUsecase placeUsecase;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
           margin: const EdgeInsets.symmetric(horizontal: 15),
           alignment: Alignment.centerLeft,
           child: Column(
            children: [
              placeUsecase.placeDesc.isEmpty ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TitleWidget(text: "Currently On:",),
                  LocationButton(placeUsecase: placeUsecase)
                ],
              )
              :
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const TitleWidget(text: "Currently On:",),
                    BodyWidget(text: placeUsecase.placeDesc),
                  ],
                ),
              ),
            ],
          )
        ),
        Visibility(
          visible: placeUsecase.placeDesc.isNotEmpty,
          child: Column(
            children: [
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BodyWidget(text: "Latitude: ${placeUsecase.lat.toStringAsFixed(5)}"),
                  BodyWidget(text: "Longitude: ${placeUsecase.lon.toStringAsFixed(5)}"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
