import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:learn_it/src/on_boarding/domain/usecases/check_if_user_is_firsttimer.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo_mock.dart';

void main() {
  late OnboardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test(
    'should get a response from the [MockBoardingRepo]',
    () async {
      // Arrange
      when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => const Right(true),
      );

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => repo.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
