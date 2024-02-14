part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent extends Equatable {
  const OtpVerifyEvent();

  // @override
  // List<Object> get props => [];
}

class OtpVerifyEventRequested extends OtpVerifyEvent {
  final String token;
  final String otp;
 const OtpVerifyEventRequested({required this.token, required this.otp});

  @override
  List<Object> get props => [token, otp];

}
