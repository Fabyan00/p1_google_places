import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceBloc() : super(PlaceInitial()) {
    on<SetLoadingEvent>((event, emit){
      emit(LoadingState());
    });

    on<SetPlaceEvent>((event, emit) {
      emit(SucceedSettingPlace(double.parse(event.lat), double.parse(event.lon), event.place));
    });

    on<SetErrorPlaceEvent>((event, emit) {
      emit(FailedSettingPlace(event.message, DateTime.now()));
    });

    on<SetErrorLocationEvent>((event, emit) {
      emit(FailedSettingUserLocation(event.message));
    });
  }
}
