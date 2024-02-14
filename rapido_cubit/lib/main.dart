import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_cubit/cubit/login_cubit.dart';
import 'package:rapido_cubit/cubit/otp_cubit.dart';
import 'package:rapido_cubit/data/network_service.dart';
import 'package:rapido_cubit/data/repository.dart';
import 'package:rapido_cubit/presentation/router.dart';

void main() {
  runApp(MyApp(
      router: AppRouter(),
      repository: Repository(networkService: NetworkService()),
      loginCubit: LoginCubit(
          repository: Repository(networkService: NetworkService()))));
}

class MyApp extends StatelessWidget {
  final Repository repository;
  final AppRouter router;
  final LoginCubit loginCubit;
  const MyApp(
      {Key? key,
      required this.router,
      required this.repository,
      required this.loginCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(repository: repository),
        ),
        BlocProvider<OtpCubit>(
          create: (context) =>
              OtpCubit(repository: repository, loginCubit: loginCubit),
        ),
      ],
      child: MaterialApp(
        title: 'Rapido Cubit',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
