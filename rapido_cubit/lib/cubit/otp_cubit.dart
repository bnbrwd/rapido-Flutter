import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rapido_cubit/cubit/login_cubit.dart';
import 'package:rapido_cubit/data/models/otp_verification_response.dart';
import 'package:rapido_cubit/data/repository.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final Repository repository;
  final LoginCubit loginCubit;
  OtpCubit({required this.loginCubit, required this.repository})
      : super(OtpInitial());

  void verifyOtp(String otp, String token) {
    repository.verifyOtp(otp, token).then((otpResponse) {
      print("data in  cubit-----${otpResponse.toString()}");
      emit(OtpLoaded(otpResponse));
    });
  }
}
