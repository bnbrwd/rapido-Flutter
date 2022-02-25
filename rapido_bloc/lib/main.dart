import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_bloc/bloc/locationpermission_given_bloc.dart';
import 'package:rapido_bloc/bloc/login_bloc.dart';
import 'package:rapido_bloc/bloc/otp_verify_bloc.dart';
import 'package:rapido_bloc/data/network_service.dart';
import 'package:rapido_bloc/data/repository.dart';
import 'package:rapido_bloc/presentation/router.dart';

void main() {
  runApp(MyApp(
    router: AppRouter(),
    repository: Repository(networkService: NetworkService()),
    loginBloc:
        LoginBloc(repository: Repository(networkService: NetworkService())),
    otpVerifyBloc: OtpVerifyBloc(
        repository: Repository(networkService: NetworkService()),
        loginBloc: LoginBloc(
            repository: Repository(networkService: NetworkService()))),
  ));
}

class MyApp extends StatelessWidget {
  final Repository repository;
  final AppRouter router;
  final LoginBloc loginBloc;
  final OtpVerifyBloc otpVerifyBloc;

  const MyApp(
      {Key? key,
      required this.repository,
      required this.router,
      required this.loginBloc,
      required this.otpVerifyBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(repository: repository)),
        BlocProvider(
            create: (context) =>
                OtpVerifyBloc(repository: repository, loginBloc: loginBloc)),
         BlocProvider(create: (context) => LocationpermissionGivenBloc(repository: repository)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
