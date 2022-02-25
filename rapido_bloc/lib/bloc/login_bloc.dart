import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapido_bloc/data/models/login_response.dart';
import 'package:rapido_bloc/data/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final Repository repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{

      if(event is LoginEventRequested){
        emit(LoginLoading());
        try{
          final LoginResponse loginResponse = await repository.fetchLogin(event.phone);
          emit(LoginSuccess(loginResponse: loginResponse));
        }catch(exception){
          emit(LoginFailure());
        }
      }
    });
  }
}
