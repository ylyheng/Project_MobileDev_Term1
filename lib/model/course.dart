import 'exam.dart';

// A course HAS exams (composition: exams belong to the course).
class Course {
  String id;
  String name;
  String day; // e.g. "Monday"
  String startTime; // e.g. "08:00"
  String endTime; // e.g. "10:00"
  String? room; // optional, can be null
  List<Exam> exams = [];

  Course(this.id, this.name, this.day, this.startTime, this.endTime,
      {this.room});

  void addExam(Exam exam) {
    exams.add(exam);
  }
}
