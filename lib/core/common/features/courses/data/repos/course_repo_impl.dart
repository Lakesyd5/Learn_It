import 'package:dartz/dartz.dart';
import 'package:learn_it/core/common/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/common/features/courses/domain/repo/course_repo.dart';
import 'package:learn_it/core/utils/typeDefs.dart';

class CourseRepoImpl implements CourseRepo {
  CourseRepoImpl(this._remoteDataSource);

  final CourseRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addCourse(Course course) async {
    await _remoteDataSource.addCourse(course);
    return const Right(null);
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    // TODO: implement getCourses
    throw UnimplementedError();
  }
}
