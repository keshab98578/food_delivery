import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/courses/domain/usecases/course_usecase.dart';
import 'package:student_management_starter/features/courses/presentation/state/course_state.dart';

//Provider
final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(ref.read(courseUsecaseProvider));
});

class CourseViewModel extends StateNotifier<CourseState> {
  CourseViewModel(this.courseUseCase) : super(CourseState.initial()) {
    getAllCourses();
  }

  final CourseUseCase courseUseCase;

// to delete course
  deleteCourse(CourseEntity course) async {
    state.copyWith(isLoading: true);
    var data = await courseUseCase.deleteCourse(course.courseId!);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state.lstCourses.remove(course);
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(
          message: 'Course delete successfully',
        );
      },
    );
  }

  addCourse(CourseEntity course) async {
    //to show the progressbar
    state = state.copyWith(isLoading: true);
    var data = await courseUseCase.addCourse(course);

    data.fold(
      (l) {
        //show error message
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        //show success message
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: 'Course added successfully!');
      },
    );
    getAllCourses();
  }

  //for getting all courses
  getAllCourses() async {
    //To show the progress bar
    state = state.copyWith(isLoading: true);
    var data = await courseUseCase.getAllCourses();

    data.fold(
      (l) {
        //show error message
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        //show success message or simply load data in UI
        state = state.copyWith(isLoading: false, lstCourses: r, error: null);
      },
    );
  }
}
