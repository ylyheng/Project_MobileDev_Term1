import 'course.dart';
import 'task.dart';

// A student HAS tasks (composition) and is enrolled in courses (aggregation).
class Student {
  String name;
  List<Course> courses = [];
  List<Task> tasks = [];

  Student(this.name);
}
