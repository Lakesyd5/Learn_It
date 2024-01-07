import 'package:learn_it/core/usecases/usecases.dart';
import 'package:learn_it/core/utils/typeDefs.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
  
}
