import 'package:learn_it/core/usecases/usecases.dart';
import 'package:learn_it/core/utils/typeDefs.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnboardingRepo _repo;
  
  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
