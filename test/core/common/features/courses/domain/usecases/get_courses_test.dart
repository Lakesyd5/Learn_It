import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/common/features/courses/domain/usecases/get_courses.dart';
import 'package:mocktail/mocktail.dart';

import '../course_repo_mock.dart';

void main() {
  late CourseRepo repo;
  late GetCourses usecase;

  setUp(() {
    repo = MockCourseRepo();
    usecase = GetCourses(repo);
  });
  test('should call [MockRepo.GetCourses].', () async {
    when(() => repo.getCourses()).thenAnswer((_) async => const Right([]));

    final result = await usecase();

    expect(result, const Right<dynamic, List<Course>>([]));
    verify(() => repo.getCourses()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
