import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResultUtils', () {
    test('returns a right value for a successful remote request', () async {
      final result = await ResultUtils.guardRemote(() async => 42);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => 0), 42);
    });

    test('maps a Dio response message to Failure', () async {
      final result = await ResultUtils.guardRemote<int>(() async {
        throw DioException(
          requestOptions: RequestOptions(path: '/sample'),
          response: Response(
            requestOptions: RequestOptions(path: '/sample'),
            statusCode: 400,
            data: {'message': 'Invalid sample'},
          ),
        );
      });

      result.fold((failure) {
        expect(failure.message, 'Invalid sample');
        expect(failure.cause, isA<DioException>());
      }, (_) => fail('Expected a left failure.'));
    });

    test('maps an unexpected exception to Failure', () async {
      final error = StateError('unexpected');
      final result = await ResultUtils.guardRemote<int>(() async {
        throw error;
      });

      result.fold((failure) {
        expect(failure.message, isNull);
        expect(failure.cause, same(error));
      }, (_) => fail('Expected a left failure.'));
    });
  });
}
