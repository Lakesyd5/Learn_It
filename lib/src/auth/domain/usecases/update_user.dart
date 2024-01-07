import 'package:equatable/equatable.dart';
import 'package:learn_it/core/enums/update_user.dart';
import 'package:learn_it/core/usecases/usecases.dart';
import 'package:learn_it/core/utils/typeDefs.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) =>
      _repo.updateUser(action: params.action, userData: params.userData);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.displayName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
