import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';
import 'package:learn_it/src/auth/domain/usecases/sign_up.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_repo_mock.dart';

void main() {
  late AuthRepo repo;
  late SignUp usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignUp(repo);
  });

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tFullname = 'Test fullName';

  test('should call the [AuthRepo.signUp]', () async {
    when(
      () => repo.signUp(
        email: any(named: 'email'),
        fullName: any(named: 'fullName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
      const SignUpParams(
        email: tEmail,
        fullName: tFullname,
        password: tPassword,
      ),
    );

    expect(result, const Right<dynamic, void>(null));
    verify(
      () => repo.signUp(
        email: tEmail,
        fullName: tFullname,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
