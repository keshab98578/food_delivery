import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/courses/domain/repository/course_repository.dart';

final courseUsecaseProvider = Provider<CourseUseCase>((ref) =>
    CourseUseCase(courseRepository: ref.read(courseRepositoryProvider)));

class CourseUseCase {
  final ICourseRepository courseRepository;

  CourseUseCase({required this.courseRepository});

  //For adding a batch
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseRepository.addCourse(course);
  }

  //For getting all batch
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseRepository.getAllCourses();
  }

 Future<Either<Failure, bool>> deleteCourse(String id) async {
    return courseRepository.deleteCourse(id);
  }
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    return const Right([]);
  }
}
