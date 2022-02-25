part of 'otp_verify_bloc.dart';

abstract class OtpVerifyState extends Equatable {
  const OtpVerifyState();

  @override
  List<Object> get props => [];
}

class OtpVerifyInitial extends OtpVerifyState {}

class OtpVerifyLoading extends OtpVerifyState {}

class OtpVerifySuccess extends OtpVerifyState {
  final OtpVerificationResponse otpVerificationResponse;
  const OtpVerifySuccess({required this.otpVerificationResponse});

  @override
  List<Object> get props => [otpVerificationResponse];
}

class OtpVerifyFailure extends OtpVerifyState {}
