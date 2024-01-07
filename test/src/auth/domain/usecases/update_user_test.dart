import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/enums/update_user.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';
import 'package:learn_it/src/auth/domain/usecases/update_user.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_repo_mock.dart';

void main() {
  late AuthRepo repo;
  late UpdateUser usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = UpdateUser(repo);
    registerFallbackValue(UpdateUserAction.email);
  });

  test('should call [AuthRepo.updateUser]', () async {
    when(
      () => repo.updateUser(
        action: any(named: 'action'),
        userData: any<dynamic>(named: 'userData'),
      ),
    ).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase(
      const UpdateUserParams(
        action: UpdateUserAction.email,
        userData: 'Test email',
      ),
    );

    expect(result, const Right<dynamic, void>(null));
    verify(
      () => repo.updateUser(
        action: UpdateUserAction.email,
        userData: 'Test email',
      ),
    );
    verifyNoMoreInteractions(repo);
  });
}
