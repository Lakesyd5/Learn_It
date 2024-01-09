import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/enums/update_user.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/core/errors/failures.dart';
import 'package:learn_it/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:learn_it/src/auth/data/model/user_model.dart';
import 'package:learn_it/src/auth/data/repos/auth_repo_impl.dart';
import 'package:learn_it/src/auth/domain/repos/auth_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource authRemoteDataSource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    authRemoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthRepoImpl(authRemoteDataSource);
    registerFallbackValue(UpdateUserAction.password);
  });

  const tPassword = 'Test password';
  const tFullName = 'Test full name';
  const tEmail = 'Test email';
  const tUpdateAction = UpdateUserAction.password;
  const tUserData = 'New password';

  const tUser = LocalUserModel.empty();

  test('should be a subclass of [authRepo]', () {
    expect(repoImpl, isA<AuthRepo>());
  });

  group('forgotPassword', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(() => authRemoteDataSource.forgotPassword(any())).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.forgotPassword(tEmail);

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => authRemoteDataSource.forgotPassword(tEmail)).called(1);
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );

    test(
      'should return [serverFailure] when call to remote source is unsuccessful',
      () async {
        when(() => authRemoteDataSource.forgotPassword(any())).thenThrow(
          const ServerException(
            message: 'User does not exist',
            statusCode: '404',
          ),
        );

        final result = await repoImpl.forgotPassword(tEmail);

        expect(
          result,
          equals(
            const Left<ServerFailure, void>(
              ServerFailure(
                message: 'User does not exist',
                statusCode: '404',
              ),
            ),
          ),
        );

        verify(() => authRemoteDataSource.forgotPassword(tEmail)).called(1);
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );
  });

  group('signIn', () {
    test(
      'should return a valid [localUserModel] when call to remote source is successful',
      () async {
        when(() => authRemoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'))).thenAnswer(
          (_) async => Future.value(tUser),
        );

        final result =
            await repoImpl.signIn(email: tEmail, password: tPassword);

        expect(
          result,
          equals(
            const Right<dynamic, LocalUserModel>(tUser),
          ),
        );
        verify(
          () => authRemoteDataSource.signIn(email: tEmail, password: tPassword),
        );
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );

    test(
      'should return a [serveFailure] when call to remote source is unsuccessful',
      () async {
        when(() => authRemoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'))).thenThrow(
          const ServerException(
            message: 'Unknown error occured',
            statusCode: '400',
          ),
        );

        final result =
            await repoImpl.signIn(email: tEmail, password: tPassword);

        expect(
          result,
          equals(
            const Left<ServerFailure, LocalUserModel>(
              ServerFailure(
                message: 'Unknown error occured',
                statusCode: '400',
              ),
            ),
          ),
        );

        verify(
          () => authRemoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );
  });

  group('signUp', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(
          () => authRemoteDataSource.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            fullName: any(named: 'fullName'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => authRemoteDataSource.signUp(
            email: tEmail,
            password: tPassword,
            fullName: tFullName,
          ),
        ).called(1);
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );

    test(
      'should return a [serverFailure] when call to remote source is unsuccessful',
      () async {
        when(
          () => authRemoteDataSource.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            fullName: any(named: 'fullName'),
          ),
        ).thenThrow(
          const ServerException(
            message: 'Unknown error occured',
            statusCode: '400',
          ),
        );

        final result = await repoImpl.signUp(
            email: tEmail, fullName: tFullName, password: tPassword);

        expect(
          result,
          equals(
            const Left<ServerFailure, void>(
              ServerFailure(
                message: 'Unknown error occured',
                statusCode: '400',
              ),
            ),
          ),
        );

        verify(
          () => authRemoteDataSource.signUp(
            email: tEmail,
            password: tPassword,
            fullName: tFullName,
          ),
        );
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );
  });

  group('updateUser', () {
    test(
      'should complete successully when call to remote source is successful',
      () async {
        when(() => authRemoteDataSource.updateUser(
            action: tUpdateAction,
            userData: any<dynamic>(named: 'userData'))).thenAnswer(
          (_) => Future.value(),
        );

        final result = await repoImpl.updateUser(
            action: tUpdateAction, userData: tUserData);

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => authRemoteDataSource.updateUser(
            action: tUpdateAction,
            userData: tUserData,
          ),
        ).called(1);
        verifyNoMoreInteractions(authRemoteDataSource);
      },
    );
  });
}
