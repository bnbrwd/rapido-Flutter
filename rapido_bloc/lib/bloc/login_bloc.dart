import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapido_bloc/components/validators.dart';
import 'package:rapido_bloc/data/models/login_response.dart';
import 'package:rapido_bloc/data/repository.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  final Repository repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginEventRequested) {
        emit(LoginLoading());
        try {
          final LoginResponse loginResponse =
              await repository.fetchLogin(event.phone);
          emit(LoginSuccess(loginResponse: loginResponse));
        } catch (exception) {
          emit(LoginFailure());
        }
      }
    });
  }

  

  final _phoneNumber = BehaviorSubject<String>();
  // //Getters  //sink used for input and stream used for output.
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneValidator);
 // //Setters  //sink used for input and stream used for output.
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  void dispose() {
    _phoneNumber.close();
  }
}
