import 'package:learn_it/core/common/features/courses/data/models/course_model.dart';
import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';

abstract class CourseRemoteDataSource {
  Future<void> addCourse(Course course);
  Future<List<CourseModel>> getCourses();
}
