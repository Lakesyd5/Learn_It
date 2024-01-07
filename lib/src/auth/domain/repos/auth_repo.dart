import 'package:learn_it/core/enums/update_user.dart';
import 'package:learn_it/core/utils/typedefs.dart';
import 'package:learn_it/src/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
