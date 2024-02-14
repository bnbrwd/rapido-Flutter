import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rapido_bloc/bloc/locationpermission_given_bloc.dart';
import 'package:rapido_bloc/bloc/locationpermission_not_given_bloc.dart';
import 'package:rapido_bloc/bloc/login_bloc.dart';
import 'package:rapido_bloc/bloc/otp_verify_bloc.dart';
import 'package:rapido_bloc/data/network_service.dart';
import 'package:rapido_bloc/data/repository.dart';
import 'package:rapido_bloc/presentation/screens/location_permission_given.dart';
import 'package:rapido_bloc/presentation/screens/location_permission_not_given.dart';
import 'package:rapido_bloc/presentation/screens/login_screen.dart';
import 'package:rapido_bloc/presentation/screens/otp_screen.dart';
import 'package:rapido_bloc/splash_screen.dart';

class MockService extends Mock implements NetworkService {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  late MockService mockService;
  late Repository repository;
  late LoginBloc loginBloc;

  setUp(() {
    mockService = MockService();
    repository = Repository(networkService: mockService);
    loginBloc = LoginBloc(repository: repository);
  });

  Widget multiBlocProviderTest({Widget? child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(repository: repository)),
        BlocProvider(
            create: (context) =>
                OtpVerifyBloc(repository: repository, loginBloc: loginBloc)),
        BlocProvider(
            create: (context) =>
                LocationpermissionGivenBloc(repository: repository)),
        BlocProvider(
            create: (context) =>
                LocationpermissionNotGivenBloc(repository: repository)),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('Login integration testing', () {
    testWidgets('When app start it should open splash screen', (tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: SplachScreen()));
      expect(find.byType(SplachScreen), findsOneWidget);
    });

    testWidgets('When login page renders', (tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (_) => LoginBloc(repository: repository),
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ));
      expect(find.byType(LoginScreen), findsOneWidget);
    });
    testWidgets('When mobile number entered  then Otp page should render.',
        (tester) async {
      await tester.pumpWidget(multiBlocProviderTest(child: LoginScreen()));

      const inputMobileNo = '8951516545';
      await tester.enterText(find.byKey(const Key('mobileKey')), inputMobileNo);

      await tester.tap(find.byKey(const Key('tapLogin')));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen, skipOffstage: false), findsNothing);
      expect(find.byType(OTPScreen), findsOneWidget);
    });

    // testWidgets('When otp entered  then locationgiven page should render.',
    //     (tester) async {
    //   await tester.pumpWidget(multiBlocProviderTest(child: const OTPScreen()));

    //   // const mobileOtp = '123456';
    //   // await tester.enterText(find.byKey(const Key('otpentered')), mobileOtp);

    //   await tester.tap(find.byKey(const Key('tapotpverify')));
    //   await tester.pumpAndSettle();

    //   expect(find.byType(LocationPermissionGiven), findsOneWidget);
    // });

    testWidgets('When name and city entered into LocationPermissionGiven page',
        (tester) async {
      await tester
          .pumpWidget(multiBlocProviderTest(child: LocationPermissionGiven()));

      const inputName = 'Alex';
      await tester.enterText(find.byKey(const Key('namefield')), inputName);

      const inputCity = 'Ranchi';
      await tester.enterText(find.byKey(const Key('cityfield')), inputCity);

      await tester.tap(find.byKey(const Key('tapNext')));
      await tester.pumpAndSettle();

      expect(find.byType(LocationPermissionNotGiven), findsOneWidget);
    });
  });
}
