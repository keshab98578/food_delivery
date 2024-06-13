// create provider for BatchLocalDataSource
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchLocalDataSourceProvider = Provider((ref) => BatchLocalDataSource(
      hiveService: ref.read(hiveServiceProvider), //Passing Hive Service Object
      batchHiveModel:
          ref.read(batchHiveModelProvider), //Passing BatchHiveModel Object
    ));

class BatchLocalDataSource {
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    required this.batchHiveModel,
  });

  //Add Batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      //convert Entity to Hive Object
      final hiveBatch = batchHiveModel.fromEntity(batch);

      // Add to Hive
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //get all batches

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      //get all batches from hive
      final hiveBatches = await hiveService.getAllBatches();

      //convert hive list to  entity list
      //As the database returns BatchHiveModel

      final batches = batchHiveModel.toEntityList(hiveBatches);
      return Right(batches);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Delete Batch
  Future<Either<Failure, bool>> deleteBatch(String id) async {
    try {
      // Delete Batch from Hive
      await hiveService.deleteBatch(id);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
