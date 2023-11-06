part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  OnNewUserLocationEvent(this.newLocation);
}

class onStartFollowingUser extends LocationEvent {}

class onStopFollowingUser extends LocationEvent {}
