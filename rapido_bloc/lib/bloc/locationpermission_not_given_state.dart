part of 'locationpermission_not_given_bloc.dart';

abstract class LocationpermissionNotGivenState extends Equatable {
  const LocationpermissionNotGivenState();

  @override
  List<Object> get props => [];
}

class LocationpermissionNotGivenInitial
    extends LocationpermissionNotGivenState {}

class LocationpermissionNotGivenLoading
    extends LocationpermissionNotGivenState {}

class LocationpermissionNotGivenSuccess
    extends LocationpermissionNotGivenState {
  final LocationPermissionNotGivenResponse locationPermissionNotGivenResponse;

  const LocationpermissionNotGivenSuccess(
      {required this.locationPermissionNotGivenResponse});

  @override
  List<Object> get props => [locationPermissionNotGivenResponse];
}

class LocationpermissionNotGivenFailure
    extends LocationpermissionNotGivenState {}
