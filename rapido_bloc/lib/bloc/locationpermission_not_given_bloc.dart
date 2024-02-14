import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapido_bloc/data/models/locationpermission_not_given_response.dart';
import 'package:rapido_bloc/data/repository.dart';

part 'locationpermission_not_given_event.dart';
part 'locationpermission_not_given_state.dart';

class LocationpermissionNotGivenBloc extends Bloc<
    LocationpermissionNotGivenEvent, LocationpermissionNotGivenState> {
  final Repository repository;
  LocationpermissionNotGivenBloc({required this.repository})
      : super(LocationpermissionNotGivenInitial()) {
    on<LocationpermissionNotGivenEvent>((event, emit) async {
      if (event is LocationpermissionNotGivenRequested) {
        emit(LocationpermissionNotGivenLoading());

        try {
          final LocationPermissionNotGivenResponse
              locationPermissionNotGivenResponse = await repository
                  .getLocationPermisionNotGiven(event.city, event.name);
          emit(LocationpermissionNotGivenSuccess(
              locationPermissionNotGivenResponse:
                  locationPermissionNotGivenResponse));
        } catch (exception) {
          emit(LocationpermissionNotGivenFailure());
        }
      }
    });
  }
}
