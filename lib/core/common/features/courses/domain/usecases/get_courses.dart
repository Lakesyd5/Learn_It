import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/usecases/usecases.dart';
import 'package:learn_it/core/utils/typeDefs.dart';

class GetCourses extends UsecaseWithoutParams<List<Course>> {
  GetCourses(this._repo);

  final CourseRepo _repo;
  @override
  ResultFuture<List<Course>> call() async => _repo.getCourses();

}
