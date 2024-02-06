import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/common/features/courses/domain/usecases/add_course.dart';
import 'package:mocktail/mocktail.dart';

import '../course_repo_mock.dart';

void main() {
  late CourseRepo repo;
  late AddCourse usecase;

  final tCourse = Course.empty();

  setUp(() {
    repo = MockCourseRepo();
    usecase = AddCourse(repo);
    registerFallbackValue(tCourse);
  });

  test('should call the [CourseRepo.AddCourses]', () async {
    when(() => repo.addCourse(any())).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase(tCourse);

    expect(result, const Right<dynamic, void>(null));
    verify(
      () => repo.addCourse(tCourse),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
