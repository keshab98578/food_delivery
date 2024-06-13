import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_management_starter/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management_starter/features/auth/presentation/viewmodel/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  File? _img;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _pickImage(WidgetRef ref, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        setState(() {
          _img = file;
          ref.read(authViewModelProvider.notifier).uploadImage(file);
        });
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isRestricted || status.isDenied) {
      debugPrint('Camera permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _checkCameraPermission();
                                  _pickImage(ref, ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _pickImage(ref, ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _fnameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lnameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var student = AuthEntity(
                          fname: _fnameController.text,
                          lname: _lnameController.text,
                          image: _img != null ? _img!.path : '',
                          phone: _phoneController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                        ref
                            .read(authViewModelProvider.notifier)
                            .registerStudent(student);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

    // Uncomment the batch and course selection blocks as needed
                  // Batch Selection
                  // if (batchState.isLoading) ...[
                  //   const Center(
                  //     child: CircularProgressIndicator(),
                  //   )
                  // ] else if (batchState.error != null) ...[
                  //   Center(
                  //     child: Text(batchState.error!),
                  //   )
                  // ] else ...[
                  //   DropdownButtonFormField<BatchEntity>(
                  //     items: batchState.lstBatches
                  //         .map((e) => DropdownMenuItem<BatchEntity>(
                  //               value: e,
                  //               child: Text(e.batchName),
                  //             ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       _dropDownValue = value;
                  //     },
                  //     value: _dropDownValue,
                  //     decoration: const InputDecoration(
                  //       labelText: 'Select Batch',
                  //     ),
                  //     validator: (value) {
                  //       if (value == null) {
                  //         return 'Please select batch';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ],
                  // _gap,
                  // Course Selection
                  // if (courseState.isLoading) ...[
                  //   const Center(
                  //     child: CircularProgressIndicator(),
                  //   )
                  // ] else if (courseState.error != null) ...[
                  //   Center(
                  //     child: Text(courseState.error!),
                  //   )
                  // ] else ...[
                  //   MultiSelectDialogField(
                  //     title: const Text('Select course'),
                  //     items: courseState.lstCourses
                  //         .map(
                  //           (course) => MultiSelectItem(
                  //             course,
                  //             course.courseName,
                  //           ),
                  //         )
                  //         .toList(),
                  //     listType: MultiSelectListType.CHIP,
                  //     buttonText: const Text(
                  //       'Select course',
                  //       style: TextStyle(color: Colors.black),
                  //     ),
                  //     buttonIcon: const Icon(Icons.search),
                  //     onConfirm: (values) {
                  //       _lstCourseSelected.clear();
                  //       _lstCourseSelected.addAll(values);
                  //     },
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.black87,
                  //       ),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please select courses';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ],