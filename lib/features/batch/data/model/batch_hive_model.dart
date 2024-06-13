import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_starter/app/constants/hive_table_constant.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:uuid/uuid.dart';

part 'batch_hive_model.g.dart';

//Provider
final batchHiveModelProvider = Provider(
  (ref) => BatchHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel {
  @HiveField(0)
  final String? batchId;
  @HiveField(1)
  final String batchName;

  BatchHiveModel({
    String? batchId,
    required this.batchName,
  }) : batchId = batchId ?? const Uuid().v4();

  BatchHiveModel.empty()
      : batchId = '',
        batchName = '';

  //convert hive object to entity
  BatchEntity toEntity() => BatchEntity(batchId: batchId, batchName: batchName);

  //convert entity to hive object
  BatchHiveModel fromEntity(BatchEntity entity) => BatchHiveModel(
        batchId: entity.batchId,
        batchName: entity.batchName,
      );

  //convert hive list to entity list
  List<BatchEntity> toEntityList(List<BatchHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
