import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_cubit/constant/strings.dart';
import 'package:rapido_cubit/cubit/login_cubit.dart';
import 'package:rapido_cubit/cubit/otp_cubit.dart';
import 'package:rapido_cubit/data/models/login_response.dart';
import 'package:rapido_cubit/data/network_service.dart';
import 'package:rapido_cubit/data/repository.dart';
import 'package:rapido_cubit/presentation/screens/location_permission_given.dart';
import 'package:rapido_cubit/presentation/screens/location_permission_not_given.dart';
import 'package:rapido_cubit/presentation/screens/login_screen.dart';
import 'package:rapido_cubit/presentation/screens/otp_screen.dart';
import 'package:rapido_cubit/splash_screen.dart';

class AppRouter {
  late Repository repository;
  late LoginCubit loginCubit;
  AppRouter() {
    repository = Repository(networkService: NetworkService());
    loginCubit = LoginCubit(repository: repository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplachScreen());
      case LOGIN_SCREEN_ROUTE:
        return MaterialPageRoute(
          //by wraping with BlocProvider we can listen data that emitted by cubit
          builder: (_) => BlocProvider.value(
            value: loginCubit,
            child: LoginScreen(),
          ),
        );
      case OTP_SCREEN_ROUTE:
        // final loginRes = settings.arguments as LoginResponse;
        return MaterialPageRoute(
          //by wraping with BlocProvider we can listen data that emitted by cubit
          builder: (_) => BlocProvider(
            create: (context) =>
                OtpCubit(repository: repository, loginCubit: loginCubit),
            // child: OTPScreen(loginResponse: loginRes),
            child: OTPScreen(),
          ),
        );
      case LOCATIONPERMISSION_GIVEN_ROUTE:
        return MaterialPageRoute(builder: (_) => LocationPermissionGiven());
      
      case LOCATIONPERMISSION_NOT_GIVEN_ROUTE:
        return MaterialPageRoute(builder: (_) => LocationPermissionNotGiven());
    }
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