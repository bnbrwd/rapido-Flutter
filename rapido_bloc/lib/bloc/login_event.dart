part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  // @override
  // List<Object> get props => [];
}

class LoginEventRequested extends LoginEvent {
  final String phone;
 const LoginEventRequested({required this.phone});

  @override
  List<Object> get props => [phone];

}

