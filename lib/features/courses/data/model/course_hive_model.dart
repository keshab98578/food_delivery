import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_starter/app/constants/hive_table_constant.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';
import 'package:uuid/uuid.dart';

part 'course_hive_model.g.dart';

//Provider
final courseHiveModelProvider = Provider(
  (ref) => CourseHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel {
  @HiveField(0)
  final String? courseId;
  @HiveField(1)
  final String courseName;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

  CourseHiveModel.empty()
      : courseId = '',
        courseName = '';

  //convert hive object to entity
  CourseEntity toEntity() =>
      CourseEntity(courseId: courseId, courseName: courseName);

  //convert entity to hive object
  CourseHiveModel fromEntity(CourseEntity entity) => CourseHiveModel(
        courseId: entity.courseId,
        courseName: entity.courseName,
      );

  //convert hive list to entity list
  List<CourseEntity> toEntityList(List<CourseHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  // to hive model
  List<CourseHiveModel> fromEntityList(List<CourseEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }

  @override
  String toString() {
    return 'courseId: $courseId, courseName: $courseName';
  }
}
