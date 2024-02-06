import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/utils/typeDefs.dart';

abstract class CourseRepo {
  const CourseRepo();

  ResultFuture<List<Course>> getCourses();

  ResultFuture<void> addCourse(Course course);
}
