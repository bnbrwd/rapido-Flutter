import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_bloc/bloc/locationpermission_given_bloc.dart';
import 'package:rapido_bloc/bloc/login_bloc.dart';
import 'package:rapido_bloc/bloc/otp_verify_bloc.dart';
import 'package:rapido_bloc/constant/strings.dart';
import 'package:rapido_bloc/data/network_service.dart';
import 'package:rapido_bloc/data/repository.dart';
import 'package:rapido_bloc/presentation/screens/location_permission_given.dart';
import 'package:rapido_bloc/presentation/screens/location_permission_not_given.dart';
import 'package:rapido_bloc/presentation/screens/login_screen.dart';
import 'package:rapido_bloc/presentation/screens/otp_screen.dart';
import 'package:rapido_bloc/splash_screen.dart';

class AppRouter {
  late Repository repository;
  late LoginBloc loginBloc;
  late OtpVerifyBloc otpVerifyBloc;
  AppRouter() {
    repository = Repository(networkService: NetworkService());
    loginBloc = LoginBloc(repository: repository);
    otpVerifyBloc = OtpVerifyBloc(repository: repository, loginBloc: loginBloc);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplachScreen());
      case LOGIN_SCREEN_ROUTE:
        return MaterialPageRoute(
          //by wraping with BlocProvider we can listen data that emitted by cubit
          builder: (_) => BlocProvider.value(
            value: loginBloc,
            child: LoginScreen(),
          ),
        );
      case OTP_SCREEN_ROUTE:
        return MaterialPageRoute(
          //by wraping with BlocProvider we can listen data that emitted by cubit
          builder: (_) => BlocProvider(
            create: (context) => OtpVerifyBloc(
              repository: repository,
              loginBloc: loginBloc,
            ),
            child: const OTPScreen(),
          ),
        );
      case LOCATIONPERMISSION_GIVEN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LocationpermissionGivenBloc(repository: repository),
                  child: LocationPermissionGiven(),
                ));

      case LOCATIONPERMISSION_NOT_GIVEN_ROUTE:
        return MaterialPageRoute(builder: (_) => LocationPermissionNotGiven());
    }
    return null;
  }
}


// case LOGIN_SCREEN_ROUTE:
//         return MaterialPageRoute(
//           //by wraping with BlocProvider we can listen data that emitted by cubit
//           builder: (_) => BlocProvider(
//             create: (context) => LoginCubit(repository: repository),
//             child: LoginScreen(),
//           ),
//         );