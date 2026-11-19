# Velea - Milestone 2 Report

Mobile Dev Term 1 - Gen 11  
Student: Y lyheng

## 1. Architecture

```
velea/
├── lib/
│   ├── model/
│   │   ├── student.dart
│   │   ├── course.dart
│   │   ├── exam.dart
│   │   └── task.dart
│   └── service/
│       └── task_service.dart
└── test/
    └── task_service_test.dart
```

- `model/`: stores the main data used by the app.
- `service/`: contains the actions and rules for tasks.
- `test/`: checks that the service works correctly.

## 2. Model Layer

| Class | Purpose | Main data |
|---|---|---|
| `Student` | Represents the student | name, courses, tasks |
| `Course` | Represents a subject and its class time | id, name, day, start time, end time, room, exams |
| `Exam` | Represents an exam | title, date |
| `Task` | Represents an assignment or to-do item | id, title, due date, priority, completed status, course |

### Relationships
- A `Student` owns their `Task` objects.
- A `Course` owns its `Exam` objects.
- A `Task` can be linked to a `Course`.
- A `Student` can be enrolled in many `Course` objects.

This connects the student's tasks with their courses, classes, and exams.

## 3. Service Layer (`TaskService`)

| Operation | Description | Rule |
|---|---|---|
| `addTask` | Creates a task and can connect it to a course | The title cannot be blank. The date cannot be in the past. The course must exist. |
| `toggleComplete` | Completes or reopens a task | Changes only the selected task. |
| `deleteTask` | Deletes a task | The delete action must be confirmed. |
| `tasksForCourse` | Gets all tasks for one course | Uses the student, task, and course data. |
| `filterByStatus` | Gets completed or incomplete tasks | Returns an empty list when there is no match. |



## 4. Test Layer (10 tests)

| Type | Tests |
|---|---|
| Normal | Add a task with a course; complete one task; delete a task; get tasks for one course |
| Invalid | Blank title; past due date; course not found; delete without confirmation |
| Boundary / special | A task due today is accepted; no-match filtering returns an empty list |

