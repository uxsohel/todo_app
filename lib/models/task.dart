enum Priority { high, medium, low }

enum TaskStatus { todo, inProgress, completed, pused }

extension PriorityLabel on Priority {
  String get label => switch (this) {
        Priority.high => 'High',
        Priority.medium => 'Medium',
        Priority.low => 'Low',
      };
}

extension TaskStatusLabel on TaskStatus {
  String get label => switch (this) {
        TaskStatus.todo => 'To Do',
        TaskStatus.inProgress => 'In Progress',
        TaskStatus.completed => 'Completed',
        TaskStatus.pused => 'Pused',
      };
}

class Task {
  const Task({
    required this.id,
    required this.category,
    required this.title,
    required this.progress, // 0.0 to 1.0
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status,
  });

  final String id;
  final String category;
  final String title;
  final double progress;
  final DateTime startDate;
  final DateTime endDate;
  final Priority priority;
  final TaskStatus status;
}

/// "12 Oct 2026"
String formatDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}
