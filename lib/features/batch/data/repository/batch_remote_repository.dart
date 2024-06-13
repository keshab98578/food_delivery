import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/batch/data/data_source/remote/batch_remote_data_source.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/repository/batch_repository.dart';

final batchRemoteRepository = Provider<IBatchRepository>((ref) {
  return BatchRemoteRepositoryImpl(
    batchRemoteDataSource: ref.read(batchRemoteDataSourceProvider),
  );
});

class BatchRemoteRepositoryImpl implements IBatchRepository {
  final BatchRemoteDataSource batchRemoteDataSource;

  BatchRemoteRepositoryImpl({required this.batchRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) {
    return batchRemoteDataSource.addBatch(batch);
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    return batchRemoteDataSource.getAllBatches();
  }

  @override
  Future<Either<Failure, bool>> deleteBatch(String id) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }
}
