part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoaded extends OtpState {
  OtpVerificationResponse otpVerificationResponse;
  OtpLoaded(this.otpVerificationResponse);
}
