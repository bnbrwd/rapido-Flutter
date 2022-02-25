part of 'locationpermission_given_bloc.dart';

abstract class LocationpermissionGivenState extends Equatable {
  const LocationpermissionGivenState();
  
  @override
  List<Object> get props => [];
}

class LocationpermissionGivenInitial extends LocationpermissionGivenState {}

class LocationpermissionGivenLoading extends LocationpermissionGivenState {}

class LocationpermissionGivenSuccess extends LocationpermissionGivenState {
  
  final LocationPermissionGivenResponse locationPermissionGivenResponse;

  const LocationpermissionGivenSuccess({required this.locationPermissionGivenResponse});

  @override
  List<Object> get props => [locationPermissionGivenResponse];
}

class LocationpermissionGivenFailure extends LocationpermissionGivenState {}
