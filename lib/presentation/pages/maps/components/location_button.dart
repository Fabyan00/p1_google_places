import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p1_places_api/domain/places_usecase.dart';
import 'package:p1_places_api/presentation/bloc/place/place_bloc.dart';
import 'package:p1_places_api/presentation/pages/shared/body_widget.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required this.placeUsecase,
  });

  final PlacesUsecase placeUsecase;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<PlaceBloc>(context).add(SetLoadingEvent());
        placeUsecase.determinePosition(context);
      },
      child: Container(
        width: 150,
        height: 35,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: placeUsecase.mainColor
        ),
        child: const BodyWidget(text: "Set your location", fontColor:Colors.black54),
      ),
    );
  }
}
