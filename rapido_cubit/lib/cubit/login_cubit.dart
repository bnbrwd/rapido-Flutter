import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rapido_cubit/data/models/login_response.dart';
import 'package:rapido_cubit/data/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository repository;
  LoginCubit({required this.repository}) : super(LoginInitial());

  void fetchLogin(String phone) {
    repository.fetchLogin(phone).then((loginResponse) {
      print("data in  cubit-----${loginResponse.toString()}");
      emit(LoginLoaded(loginResponse));
    });
  }
}
