import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/courses/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/courses/presentation/viewmodel/course_view_model.dart';

class LoadCourse extends StatelessWidget {
  final WidgetRef ref;
  final List<CourseEntity> lstCourses;
  const LoadCourse({super.key, required this.lstCourses, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lstCourses.length,
      itemBuilder: ((context, index) => ListTile(
            title: Text(lstCourses[index].courseName),
            subtitle: Text(lstCourses[index].courseId ?? ""),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                        'Are you sure you want to delete ${lstCourses[index].courseName}?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ref
                                .read(courseViewModelProvider.notifier)
                                .deleteCourse(lstCourses[index]);
                          },
                          child: const Text('Yes')),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          )),
    );
  }
}
