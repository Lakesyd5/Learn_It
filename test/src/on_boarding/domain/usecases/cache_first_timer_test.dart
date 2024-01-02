import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/errors/failures.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:learn_it/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo_mock.dart';

void main() {
  late OnboardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer]and return the right data',
    () async {
      when(() => repo.cacheFirstTimer()).thenAnswer(
        (_) async => const Left(
          ServerFailure(
            message: 'Unknown Error Occured',
            statusCode: 500,
          ),
        ),
      );

      final result = await usecase();

      expect(
        result,
        const Left<Failure, dynamic>(
          ServerFailure(
            message: 'Unknown Error Occured',
            statusCode: 500,
          ),
        ),
      );

      verify(
        () => repo.cacheFirstTimer(),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
