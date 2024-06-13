import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/constants/api_endpoint.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/remote/http_service.dart';
import 'package:student_management_starter/features/courses/data/dto/get_all_course_dto.dart';
import 'package:student_management_starter/features/courses/data/model/course_api_model.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';



final courseRemoteDataSourceProvider = Provider(
  (ref) => CourseRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    courseApiModel: ref.read(courseApiModelProvider),
  ),
);

class CourseRemoteDataSource {
  final Dio dio;
  final CourseApiModel courseApiModel;

  CourseRemoteDataSource({
    required this.dio,
    required this.courseApiModel,
  });

  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.fromEntity(course).toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCourse);
      if (response.statusCode == 200) {
        
        GetAllCourseDTO courseAddDTO = GetAllCourseDTO.fromJson(response.data);
        return Right(courseApiModel.toEntityList(courseAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}