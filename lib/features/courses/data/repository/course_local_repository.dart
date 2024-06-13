import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/courses/data/data_source/local/course_local_datasourse.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/courses/domain/repository/course_repository.dart';

final courseLocalRepository = Provider<ICourseRepository>((ref) {
  return CourseLocalRepository(
    courseLocalDataSource: ref.read(courseLocalDataSourceProvider),
  );
});

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalDataSource courseLocalDataSource;

  CourseLocalRepository({required this.courseLocalDataSource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseLocalDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseLocalDataSource.getAllCourses();
  }
  @override
  Future<Either<Failure, bool>> deleteCourse(String id) {
 
    return courseLocalDataSource.deleteCourse(id);
  }
}
