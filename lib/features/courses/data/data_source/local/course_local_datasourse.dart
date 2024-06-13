// create provider for BatchLocalDataSource
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/courses/data/model/course_hive_model.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';


final courseLocalDataSourceProvider = Provider((ref) => CourseLocalDataSource(
      hiveService: ref.read(hiveServiceProvider), //Passing Hive Service Object
      courseHiveModel:
          ref.read(courseHiveModelProvider), //Passing BatchHiveModel Object
    ));

class CourseLocalDataSource {
  final HiveService hiveService;
  final CourseHiveModel courseHiveModel;

  CourseLocalDataSource({
    required this.hiveService,
    required this.courseHiveModel,
  });

  //Add course
  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    try {
      //convert Entity to Hive Object
      final hiveCourse = courseHiveModel.fromEntity(course);

      // Add to Hive
      await hiveService.addCourse(hiveCourse);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //get all courses

  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      //get all courses from hive
      final hiveCourses = await hiveService.getAllCourses();

      //convert hive list to  entity list
      //As the database returns CourseHiveModel

      final courses = courseHiveModel.toEntityList(hiveCourses);
      return Right(courses);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Delete Course
  Future<Either<Failure, bool>> deleteCourse(String id) async {
    try {
      // Delete from Hive
      await hiveService.deleteCourse(id);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
