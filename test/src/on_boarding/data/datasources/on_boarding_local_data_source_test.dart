import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(prefs);
  });

  group('cacheFirstTimer', () {
    test('should call [SharefPreferences] to cache the data', () async {
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      await localDataSource.cacheFirstTimer();

      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] wwhen there is an error caching the data',
        () async {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      final methodCall = localDataSource.cacheFirstTimer;

      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call [sharedPreferences] to check if user is first tImer and return the right response from storage wehn data exists',
        () async {
      when(() => prefs.getBool(any())).thenReturn(false);

      final result = await localDataSource.checkIfUserIsFirstTimer();

      expect(result, false);
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if there is no data in storage', () async {
      when(() => prefs.getBool(any())).thenReturn(null);

      final result = await localDataSource.checkIfUserIsFirstTimer();

      expect(result, true);
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should throw a [cacheException] when there is an error retrieving data', () async {
      when(() => prefs.getBool(any())).thenThrow(Exception());

      final methodCall = localDataSource.checkIfUserIsFirstTimer;

      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.getBool(kFirstTimerKey));
      verifyNoMoreInteractions(prefs);
    });
  });
}
