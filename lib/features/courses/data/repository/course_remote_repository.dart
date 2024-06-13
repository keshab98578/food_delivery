import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';

import 'package:student_management_starter/features/courses/data/data_source/remote/course_remote_data_source.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/courses/domain/repository/course_repository.dart';

final courseRemoteRepository = Provider<ICourseRepository>((ref) {
  return CourseRemoteRepositoryImpl(
    courseRemoteDataSource: ref.read(courseRemoteDataSourceProvider),
  );
});

class CourseRemoteRepositoryImpl implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRemoteRepositoryImpl({required this.courseRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseRemoteDataSource.addCourse(course);
  }

  
 

  @override
  Future<Either<Failure, bool>> deleteCourse(String id) {
  
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
     return courseRemoteDataSource.getAllCourses();
  }
}
