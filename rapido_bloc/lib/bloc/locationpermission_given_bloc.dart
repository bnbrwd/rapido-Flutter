import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapido_bloc/components/validators.dart';
import 'package:rapido_bloc/data/models/locationpermision_given_response.dart';
import 'package:rapido_bloc/data/repository.dart';
import 'package:rxdart/rxdart.dart';

part 'locationpermission_given_event.dart';
part 'locationpermission_given_state.dart';

class LocationpermissionGivenBloc extends Bloc<LocationpermissionGivenEvent, LocationpermissionGivenState> with Validators{

  final Repository repository;
  LocationpermissionGivenBloc({required this.repository}) : super(LocationpermissionGivenInitial()) {
    on<LocationpermissionGivenEvent>((event, emit) async{
      if (event is LocationpermissionGivenRequested) {
        emit(LocationpermissionGivenLoading());
        try {
          final LocationPermissionGivenResponse locationPermissionGivenResponse =
              await repository.getLocationPermisionGiven(event.city, event.name);
          emit(LocationpermissionGivenSuccess(locationPermissionGivenResponse: locationPermissionGivenResponse));
        } catch (exception) {
          emit(LocationpermissionGivenFailure());
        }
      }
    });
  }

  final _name = BehaviorSubject<String>();
  // //Getters  //sink used for input and stream used for output.
  Stream<String> get name =>
      _name.stream.transform(nameValidator);
 // //Setters  //sink used for input and stream used for output.
  Function(String) get changeName => _name.sink.add;

  final _city = BehaviorSubject<String>();
  Stream<String> get city =>
      _city.stream.transform(cityValidator);
  Function(String) get changeCity => _city.sink.add;

  void dispose() {
    _name.close();
    _city.close();
  }
}
