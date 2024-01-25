part of 'place_bloc.dart';

sealed class PlaceState extends Equatable {
  const PlaceState();
  
  @override
  List<Object> get props => [];
}

final class PlaceInitial extends PlaceState {}

final class LoadingState extends PlaceState{}

final class SucceedSettingPlace extends PlaceState{
  final double lat;
  final double lon;
  final String place;

  const SucceedSettingPlace(this.lat, this.lon, this.place);

  @override 
  List<Object> get props => [lat, lon, place];
}

final class FailedSettingPlace extends PlaceState{
  final String message;
  final DateTime date;

  const FailedSettingPlace(this.message, this.date);

  @override 
  List<Object> get props => [message, date];
}

final class FailedSettingUserLocation extends PlaceState{
  final String message;

  const FailedSettingUserLocation(this.message);

  @override 
  List<Object> get props => [message];
}