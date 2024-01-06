import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/core/errors/failures.dart';
import 'package:learn_it/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:learn_it/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnboardingRepo]', () {
    expect(repoImpl, isA<OnboardingRepo>());
  });

  group('cacheFirstTimer', () {
    test(
      'should complete successully when call to local source is successful',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenAnswer(
          (_) => Future.value(),
        );

        final result = await repoImpl.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return [cacheFailure] when call to local source is unsuccessful',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          const CacheException(message: 'Insufficient storage'),
        );

        final result = await repoImpl.cacheFirstTimer();

        expect(
          result,
          equals(
            const Left<CacheFailure, dynamic>(
              CacheFailure(message: 'Insufficient storage', statusCode: 500),
            ),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('checkIfuserIsFirstTimer', () {
    test(
      'should return true when user is first timer',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => Future.value(true),
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();

        expect(result, const Right<dynamic, bool>(true));
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return false when user is not first timer',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenAnswer(
          (_) => Future.value(false),
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();

        expect(result, const Right<dynamic, bool>(false));
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return [cacheFailure] when call to local source is unsuccessful',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
          const CacheException(
            message: 'Insufficent permisson',
            statusCode: 403,
          ),
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();
        expect(
          result,
          const Left<CacheFailure, bool>(
            CacheFailure(
              message: 'Insufficent permisson',
              statusCode: 403,
            ),
          ),
        );
        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
