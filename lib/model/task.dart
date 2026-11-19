import 'course.dart';

// A task can be linked to a course (aggregation: the course lives on its own).
class Task {
  String id;
  String title;
  DateTime dueDate;
  String priority; // "low", "medium" or "high"
  bool isCompleted = false;
  Course? course;

  Task(this.id, this.title, this.dueDate,
      {this.priority = 'medium', this.course});
}
