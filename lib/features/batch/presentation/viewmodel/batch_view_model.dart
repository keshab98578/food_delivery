import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/usecases/batch_usecase.dart';
import 'package:student_management_starter/features/batch/presentation/state/batch_state.dart';

//Provider
final batchViewModelProvider =
    StateNotifierProvider<BatchViewModel, BatchState>((ref) {
  return BatchViewModel(ref.read(batchUsecaseProvider));
});

class BatchViewModel extends StateNotifier<BatchState> {
  BatchViewModel(this.batchUseCase) : super(BatchState.initial()) {
    getAllBatches();
  }

  final BatchUseCase batchUseCase;

  addBatch(BatchEntity batch) async {
    //to show the progressbar
    state = state.copyWith(isLoading: true);
    var data = await batchUseCase.addBatch(batch);

    data.fold(
      (l) {
        //show error message
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        //show success message
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: 'Batch added successfully!');
      },
    );
    getAllBatches();
  }

  //for getting all batches
  getAllBatches() async {
    //To show the progress bar
    state = state.copyWith(isLoading: true);
    var data = await batchUseCase.getAllBatches();

    data.fold(
      (l) {
        //show error message
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        //show success message or simply load data in UI
        state = state.copyWith(isLoading: false, lstBatches: r, error: null);
      },
    );
  }

  // For deleting a batch
  deleteBatch(BatchEntity batch) async {
    // To show the progress bar
    state = state.copyWith(isLoading: true);
    var data = await batchUseCase.deleteBatch(batch.batchId!);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state.lstBatches.remove(batch);
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Batch deleted successfully");
      },
    );

    getAllBatches();
  }
}
