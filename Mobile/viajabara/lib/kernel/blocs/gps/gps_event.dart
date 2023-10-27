part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

// este es el evento que va a modificar los estados
class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsAndPermissionEvent(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});
}
