import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p1_places_api/presentation/bloc/place/place_bloc.dart';
import 'package:p1_places_api/presentation/pages/home/home.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      BlocProvider(create: (_) => PlaceBloc()),
    ],
    child: Home()
    )
  );
}
