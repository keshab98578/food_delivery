import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/courses/data/repository/course_local_repository.dart';
import 'package:student_management_starter/features/courses/data/repository/course_remote_repository.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider<ICourseRepository>((ref) {
  return ref.read(courseLocalRepository);
});

abstract class ICourseRepository {
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
  Future<Either<Failure, bool>> deleteCourse(String id);
}
