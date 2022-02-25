// import 'package:rapido_cubit/data/models/login_request.dart' as welcomeToJson;
// import 'package:rapido_cubit/data/models/login_response.dart'
//     as welcomeFromJson;
// import 'package:rapido_cubit/data/models/otp_verification_request.dart' as req;
// import 'package:rapido_cubit/data/models/otp_verification_response.dart' as res;

import 'package:rapido_bloc/data/models/login_request.dart';
import 'package:rapido_bloc/data/models/login_response.dart';
import 'package:rapido_bloc/data/models/otp_verification_request.dart';
import 'package:rapido_bloc/data/models/otp_verification_response.dart';
import 'package:rapido_bloc/data/network_service.dart';
import 'package:rapido_bloc/data/models/login_request.dart' as welcomeToJson;
import 'package:rapido_bloc/data/models/login_response.dart' as welcomeFromJson;
import 'package:rapido_bloc/data/models/otp_verification_request.dart' as req;
import 'package:rapido_bloc/data/models/otp_verification_response.dart' as res;

class Repository {
  final NetworkService networkService;
  late LoginRequest loginRequest;
  late OtpVerificationRequest otpVerificationRequest;

  Repository({required this.networkService});

  Future<LoginResponse> fetchLogin(String phone) async {
    loginRequest = LoginRequest(phone: phone, countryCode: '91');
    var request = welcomeToJson.welcomeToJson(loginRequest);
    final loginResponseRaw = await networkService.getUserLoginData(request);
    return welcomeFromJson
        .welcomeFromJson(loginResponseRaw.body); // response in string.
  }

  Future<OtpVerificationResponse> verifyOtp({required String otp, required String token}) async {
    otpVerificationRequest = OtpVerificationRequest(otp: otp, token: token);
    final request = req.welcomeToJson(otpVerificationRequest);
    final otpResponseRaw = await networkService.getOtpVerify(request);
    return res.welcomeFromJson(otpResponseRaw.body);
  }
}
