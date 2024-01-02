import 'package:learn_it/core/usecases/usecases.dart';
import 'package:learn_it/core/utils/typeDefs.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repo);

  final OnboardingRepo _repo;

  @override
  ResultFuture<void> call() => _repo.cacheFirstTimer();
}
