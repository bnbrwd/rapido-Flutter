import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rapido_bloc/data/network_service.dart';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late NetworkService networkService;
  late MockHttp mockHttp;

  setUp(() {
    mockHttp = MockHttp();
    networkService = NetworkService();
  });

  group('When networkservice layer testing', () {
    test('When instantiates networkService with a required mockHttp', () {
      expect(NetworkService(), isNotNull);
    });
  });
}
