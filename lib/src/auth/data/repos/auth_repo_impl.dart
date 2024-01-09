import 'package:dartz/dartz.dart';
import 'package:learn_it/core/enums/update_user.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/core/errors/failures.dart';
import 'package:learn_it/core/utils/typedefs.dart';
import 'package:learn_it/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:learn_it/src/auth/domain/entities/user_entity.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  const AuthRepoImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _authRemoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) async {
    try {
      final result = await _authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.signUp(email: email, fullName: fullName, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({required UpdateUserAction action, required dynamic userData}) async {
    try {
      await _authRemoteDataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
