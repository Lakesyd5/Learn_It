import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/src/auth/domain/entities/user_entity.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';
import 'package:learn_it/src/auth/domain/usecases/sign_in.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_repo_mock.dart';

void main() {
  late AuthRepo repo;
  late SignIn usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignIn(repo);
  });

  const tUser = LocalUser.empty();

  test('should return [LocalUser] from [AuthRepo]', () async {
    when(
      () => repo.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Right(tUser),
    );

    final result = await usecase(const SignInParams(email: tEmail, password: tPassword));

    expect(result, equals(const Right<dynamic, LocalUser>(tUser)));
    verify(() => repo.signIn(email: tEmail, password: tPassword)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
