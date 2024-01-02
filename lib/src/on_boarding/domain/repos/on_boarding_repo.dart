import 'package:learn_it/core/utils/typedefs.dart';

abstract class OnboardingRepo {
  const OnboardingRepo();

  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
