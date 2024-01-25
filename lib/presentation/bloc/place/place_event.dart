part of 'place_bloc.dart';

sealed class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class SetLoadingEvent extends PlaceEvent{}

class SetPlaceEvent extends PlaceEvent{
    final String lat;
    final String lon;
    final String place;
    const SetPlaceEvent(this.lat, this.lon, this.place);

    @override
    List<Object> get props => [lat, lon, place];
}

class SetErrorPlaceEvent extends PlaceEvent{
    final String message;
    final String place;
    const SetErrorPlaceEvent(this.message, this.place);

    @override
    List<Object> get props => [message, place];
}

class SetErrorLocationEvent extends PlaceEvent{
    final String message;
    const SetErrorLocationEvent(this.message);

    @override
    List<Object> get props => [message];
}