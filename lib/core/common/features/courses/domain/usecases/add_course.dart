import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/usecases/usecases.dart';
import 'package:learn_it/core/utils/typeDefs.dart';

class AddCourse extends UsecaseWithParams<void, Course> {
  AddCourse(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<void> call(Course params) async => _repo.addCourse(params);
  
}
