import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rapido_bloc/data/models/login_response.dart';
import 'package:rapido_bloc/data/models/otp_verification_response.dart';
import 'package:rapido_bloc/data/network_service.dart';
import 'package:rapido_bloc/data/repository.dart';

class MockService extends Mock implements NetworkService {}

void main() {
  late MockService mockService;
  late Repository repository;

  setUp(() {
    mockService = MockService();
    repository = Repository(networkService: mockService);
  });

  group('Rapido repository testing when user enter phone number \n', () {
    test('When instantiates Repository with a required mockService', () {
      expect(repository, isNotNull);
    });
    test('When user enter phone number getLoginData should called once.',
        () async {
      const phoneNumber = "8951518066";
      try {
        await mockService.getUserLoginData(phoneNumber);
      } catch (_) {
        verify(() => mockService.getUserLoginData(phoneNumber)).called(1);
      }
    });
    test('When user get otp when api is call sucessfully', () async {
      const phoneNumber = "8951518066";
      try {
        final response = await mockService.getUserLoginData(phoneNumber);
        expect(LoginResponse.fromJson(response), isA<LoginResponse>);
      } catch (_) {
        verify(() => mockService.getUserLoginData(phoneNumber)).called(1);
      }
    });
  });

  group('Rapido repository testing when user enter otp for validation \n', () {
    test('When user enter otp getOtpVerify should called once.', () async {
      const otpNumber = "123456";
      try {
        await mockService.getOtpVerify(otpNumber);
      } catch (_) {
        verify(() => mockService.getOtpVerify(otpNumber)).called(1);
      }
    });

    test('When user gets login when api is call sucessfully', () async {
      const otpNumber = "123456";
      try {
        final response = await mockService.getOtpVerify(otpNumber);
        expect(OtpVerificationResponse.fromJson(response),
            isA<OtpVerificationResponse>);
      } catch (_) {
        verify(() => mockService.getOtpVerify(otpNumber)).called(1);
      }
    });
  });
}
