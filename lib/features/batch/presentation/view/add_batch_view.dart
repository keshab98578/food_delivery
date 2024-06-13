import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:student_management_starter/features/batch/presentation/widgets/load_batch.dart';

class AddBatchView extends ConsumerStatefulWidget {
  const AddBatchView({super.key});

  @override
  ConsumerState<AddBatchView> createState() => _AddBatchViewState();
}

class _AddBatchViewState extends ConsumerState<AddBatchView> {
  final _formKey = GlobalKey<FormState>();
  final gap = const SizedBox(height: 8);
  final batchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var batchState = ref.watch(batchViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                gap,
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Item',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                gap,
                TextFormField(
                  controller: batchController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'item name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item';
                    }
                    return null;
                  },
                ),

                gap,

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(batchViewModelProvider.notifier).addBatch(
                          BatchEntity(batchName: batchController.text));
                    },
                    child: const Text('Add Item'),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'List of Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                gap,
                //Display List of Courses
                if (batchState.isLoading) ...{
                  const Center(child: CircularProgressIndicator()),
                } else if (batchState.error != null) ...{
                  Text(batchState.error.toString()),
                } else if (batchState.lstBatches.isEmpty) ...{
                  const Center(
                    child: Text('No Item'),
                  )
                } else ...{
                  Expanded(
                    child: LoadBatch(
                      lstBatches: batchState.lstBatches,
                      ref: ref,
                    ),
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
