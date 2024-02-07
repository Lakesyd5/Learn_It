import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/common/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:learn_it/core/common/features/courses/data/models/course_model.dart';
import 'package:learn_it/core/common/features/courses/data/repos/course_repo_impl.dart';
import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/core/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSource extends Mock
    implements CourseRemoteDataSource {}

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late CourseRepoImpl repoImpl;

  final tCourse = CourseModel.empty();

  setUp(() {
    remoteDataSource = MockCourseRemoteDataSource();
    repoImpl = CourseRepoImpl(remoteDataSource);
    registerFallbackValue(tCourse);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  test('should be a sub class of [CourseRepo]', () {
    expect(repoImpl, isA<CourseRepo>());
  });

  group(
    'addCourse',
    () {
      test(
        'should complete successfully when call to remote source is successful',
        () async {
          when(() => remoteDataSource.addCourse(tCourse)).thenAnswer(
            (_) async => Future.value(),
          );

          final result = await repoImpl.addCourse(tCourse);

          expect(result, const Right<dynamic, void>(null));
          verify(
            () => remoteDataSource.addCourse(tCourse),
          ).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'should return [ServerFailure] when call to remoteSource is unsuccessful',
        () async {
          when(() => remoteDataSource.addCourse(any())).thenThrow(tException);

          final result = await repoImpl.addCourse(tCourse);
          expect(
            result,
            Left<Failure, void>(ServerFailure.fromException(tException)),
          );
          verify(
            () => remoteDataSource.addCourse(tCourse),
          ).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );

  group(
    'getCourse',
    () {
      test(
        'should return [List<Course>] when call to remote source is successful',
        () async {
          when(() => remoteDataSource.getCourses()).thenAnswer(
            (_) async => [tCourse],
          );

          final result = await repoImpl.getCourses();

          expect(result, isA<Right<dynamic, List<Course>>>());
          verify(() => remoteDataSource.getCourses()).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
          'should retrun [ServerException] when call to remote is unsuccessful',
          () async {
        when(
          () => remoteDataSource.getCourses(),
        ).thenThrow(tException);

        final result = await repoImpl.getCourses();

        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSource.getCourses()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      });
    },
  );
}
