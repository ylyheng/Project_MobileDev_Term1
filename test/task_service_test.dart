import 'package:flutter_test/flutter_test.dart';
import 'package:velea/model/course.dart';
import 'package:velea/model/student.dart';
import 'package:velea/model/task.dart';
import 'package:velea/service/task_service.dart';

void main() {
  Student student = Student('Lyheng');
  TaskService service = TaskService(student);
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  setUp(() {
    student = Student('Lyheng');
    student.courses.add(Course('c1', 'Mobile Dev', 'Monday', '08:00', '10:00'));
    service = TaskService(student);
  });

  // ---------- NORMAL CASES ----------
  test('NORMAL: add a valid task linked to a course', () {
    Task task = service.addTask('Milestone 2', tomorrow, courseId: 'c1');
    expect(student.tasks.length, 1);
    expect(task.course!.name, 'Mobile Dev');
  });

  test('NORMAL: completing one task does not change another', () {
    Task a = service.addTask('A', tomorrow);
    Task b = service.addTask('B', tomorrow);
    service.toggleComplete(a.id);
    expect(a.isCompleted, true);
    expect(b.isCompleted, false);
  });

  test('NORMAL: delete a task after confirmation', () {
    Task a = service.addTask('A', tomorrow);
    service.deleteTask(a.id, true);
    expect(student.tasks.isEmpty, true);
  });

  test('NORMAL: get tasks of one course', () {
    service.addTask('A', tomorrow, courseId: 'c1');
    service.addTask('B', tomorrow);
    expect(service.tasksForCourse('c1').length, 1);
  });

  // ---------- INVALID CASES ----------
  test('INVALID: blank title is rejected', () {
    expect(() => service.addTask('   ', tomorrow), throwsException);
    expect(student.tasks.isEmpty, true);
  });

  test('INVALID: due date in the past is rejected', () {
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    expect(() => service.addTask('Late', yesterday), throwsException);
  });

  test('INVALID: course that does not exist is rejected', () {
    expect(() => service.addTask('A', tomorrow, courseId: 'nope'),
        throwsException);
  });

  test('INVALID: delete without confirmation keeps the task', () {
    Task a = service.addTask('A', tomorrow);
    expect(() => service.deleteTask(a.id, false), throwsException);
    expect(student.tasks.length, 1);
  });

  // ---------- BOUNDARY / SPECIAL CASES ----------
  test('BOUNDARY: task due today is accepted', () {
    Task task = service.addTask('Today', DateTime.now());
    expect(task.title, 'Today');
  });

  test('SPECIAL: filter with no match gives empty list', () {
    service.addTask('A', tomorrow);
    expect(service.filterByStatus(true).isEmpty, true);
  });
}
