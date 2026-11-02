import 'package:flutter/foundation.dart';

import '../models/task.dart';

/// Very simple in-memory store so Create Task can talk to Home.
/// For a real app, replace with Provider / Riverpod / Bloc + a database.
class TaskStore extends ChangeNotifier {
  TaskStore._();
  static final TaskStore instance = TaskStore._();

  final List<Task> _tasks = [
    Task(
      id: '1',
      category: 'Design',
      title: 'The Logo Process',
      progress: 0.6,
      startDate: DateTime(2026, 11, 1),
      endDate: DateTime(2026, 11, 10),
      priority: Priority.high,
      status: TaskStatus.inProgress,
    ),
    Task(
      id: '2',
      category: 'Design',
      title: 'Design of the day challenge',
      progress: 0.6,
      startDate: DateTime(2026, 11, 02),
      endDate: DateTime(2026, 11, 15),
      priority: Priority.medium,
      status: TaskStatus.inProgress,
    ),
    Task(
      id: '3',
      category: 'Design',
      title: 'The Logo Process',
      progress: 0.6,
      startDate: DateTime(2026, 11, 3),
      endDate: DateTime(2026, 11, 20),
      priority: Priority.high,
      status: TaskStatus.inProgress,
    ),
    // Extra seed data so the "To Do" and "Completed" chips are not empty.
    Task(
      id: '4',
      category: 'Research',
      title: 'User interview notes',
      progress: 0,
      startDate: DateTime(2026, 2, 1),
      endDate: DateTime(2026, 2, 15),
      priority: Priority.low,
      status: TaskStatus.todo,
    ),
    Task(
      id: '5',
      category: 'Development',
      title: 'Landing page build',
      progress: 1,
      startDate: DateTime(2026, 1, 2),
      endDate: DateTime(2026, 1, 20),
      priority: Priority.medium,
      status: TaskStatus.completed,
    ),
  ];

  List<Task> get tasks => List.unmodifiable(_tasks);

  int countBy(TaskStatus status) =>
      _tasks.where((t) => t.status == status).length;

  void add(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }
}
