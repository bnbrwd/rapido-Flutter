part of 'locationpermission_not_given_bloc.dart';

abstract class LocationpermissionNotGivenEvent extends Equatable {
  const LocationpermissionNotGivenEvent();
}

class LocationpermissionNotGivenRequested
    extends LocationpermissionNotGivenEvent {
  final String name;
  final String city;
  const LocationpermissionNotGivenRequested(
      {required this.city, required this.name});

  @override
  List<Object> get props => [city, name];
}
