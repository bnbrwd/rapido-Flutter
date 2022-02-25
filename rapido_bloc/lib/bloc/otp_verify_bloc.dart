import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapido_bloc/bloc/login_bloc.dart';
import 'package:rapido_bloc/data/models/otp_verification_response.dart';
import 'package:rapido_bloc/data/repository.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final Repository repository;
  final LoginBloc loginBloc; 
  OtpVerifyBloc({required this.loginBloc, required this.repository}) : super(OtpVerifyInitial()) {
    on<OtpVerifyEvent>((event, emit) async{

      if(event is OtpVerifyEventRequested){
        emit(OtpVerifyLoading());
        try{
          final OtpVerificationResponse otpVerificationResponse = await repository.verifyOtp(otp: event.otp, token: event.token);
          emit(OtpVerifySuccess(otpVerificationResponse: otpVerificationResponse));
        }catch(exception){
          emit(OtpVerifyFailure());
        }
      }

    });
  }
}
