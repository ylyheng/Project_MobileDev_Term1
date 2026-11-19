import '../model/course.dart';
import '../model/student.dart';
import '../model/task.dart';

class TaskService {
  Student student;
  int _counter = 0;

  TaskService(this.student);

  // Operation 1: add a task (business rules inside)
  Task addTask(String title, DateTime dueDate,
      {String priority = 'medium', String? courseId}) {
    // Rule 1: title cannot be blank
    if (title.trim().isEmpty) {
      throw Exception('Title cannot be blank');
    }

    // Rule 2: due date cannot be in the past (today is OK)
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    if (due.isBefore(today)) {
      throw Exception('Due date cannot be in the past');
    }

    // Rule 3: if a course is given, it must exist (uses Student + Course + Task)
    Course? course;
    if (courseId != null) {
      for (Course c in student.courses) {
        if (c.id == courseId) course = c;
      }
      if (course == null) {
        throw Exception('Course not found');
      }
    }

    _counter++;
    Task task = Task('t$_counter', title.trim(), dueDate,
        priority: priority, course: course);
    student.tasks.add(task);
    return task;
  }

  // Operation 2: complete or reopen a task
  void toggleComplete(String taskId) {
    Task task = _findTask(taskId);
    task.isCompleted = !task.isCompleted;
  }

  // Operation 3: delete a task (must be confirmed)
  void deleteTask(String taskId, bool confirmed) {
    if (!confirmed) {
      throw Exception('Deletion must be confirmed');
    }
    Task task = _findTask(taskId);
    student.tasks.remove(task);
  }

  // Operation 4: get all tasks of one course (uses Student + Task + Course)
  List<Task> tasksForCourse(String courseId) {
    List<Task> matchingTasks = [];

    for (Task task in student.tasks) {
      if (task.course != null && task.course!.id == courseId) {
        matchingTasks.add(task);
      }
    }

    return matchingTasks;
  }

  // Operation 5: filter by completed status
  List<Task> filterByStatus(bool completed) {
    List<Task> matchingTasks = [];

    for (Task task in student.tasks) {
      if (task.isCompleted == completed) {
        matchingTasks.add(task);
      }
    }

    return matchingTasks;
  }

  Task _findTask(String taskId) {
    for (Task t in student.tasks) {
      if (t.id == taskId) return t;
    }
    throw Exception('Task not found');
  }
}
