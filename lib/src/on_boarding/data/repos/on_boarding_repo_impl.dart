import 'package:dartz/dartz.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/core/errors/failures.dart';
import 'package:learn_it/core/utils/typedefs.dart';
import 'package:learn_it/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';

class OnBoardingRepoImpl extends OnboardingRepo {
  const OnBoardingRepoImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() {
    throw UnimplementedError();
  }
}
