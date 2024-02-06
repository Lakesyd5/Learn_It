import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/common/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:learn_it/core/common/features/courses/data/models/course_model.dart';
import 'package:learn_it/core/common/features/courses/data/repos/course_repo_impl.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/errors/exception.dart';
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
        'should complete successfully call to remote source is successful',
        () async {
          when(() => remoteDataSource.addCourse(tCourse)).thenAnswer(
            (_) async => Future.value(),
          );

          final result = await repoImpl.addCourse(tCourse);

          expect(result, const Right<dynamic, void>(null));
          verify(() => remoteDataSource.addCourse(tCourse),).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );
}
