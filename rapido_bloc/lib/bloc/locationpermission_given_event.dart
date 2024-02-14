part of 'locationpermission_given_bloc.dart';

abstract class LocationpermissionGivenEvent extends Equatable {
  const LocationpermissionGivenEvent();

  // @override
  // List<Object> get props => [];
}

class LocationpermissionGivenRequested extends LocationpermissionGivenEvent {
  final String name;
  final String city;
  const LocationpermissionGivenRequested(
      {required this.city, required this.name});

  @override
  List<Object> get props => [city, name];
}
