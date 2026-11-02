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

  // MockAPI theke asha JSON ke Task object e convert korar jonno
  factory Task.fromJson(Map<String, dynamic> json) {
    // 1. Category Name er First Letter Boro kora
    String rawCategory = json['category']?.toString() ?? 'Task';
    String formattedCategory = rawCategory.isNotEmpty
        ? '${rawCategory[0].toUpperCase()}${rawCategory.substring(1).toLowerCase()}'
        : 'Task';

    // 2. Priority Fix (MockAPI theke random data ashleo jate High, Medium, Low hoy)
    Priority parsedPriority = Priority.low;
    final pString = json['priority']?.toString().toLowerCase() ?? '';

    if (pString.contains('high')) {
      parsedPriority = Priority.high;
    } else if (pString.contains('medium')) {
      parsedPriority = Priority.medium;
    } else if (pString.contains('low')) {
      parsedPriority = Priority.low;
    } else {
      // API theke "priority 51" er moto data ashle ID er upor vitti kore automatically assign hobe
      int hash = (json['id']?.toString() ?? pString).hashCode;
      if (hash % 3 == 0) parsedPriority = Priority.high;
      else if (hash % 3 == 1) parsedPriority = Priority.medium;
      else parsedPriority = Priority.low;
    }

    // 3. Status
    TaskStatus parsedStatus = TaskStatus.todo;
    final sString = json['status']?.toString().toLowerCase() ?? '';
    if (sString.contains('progress')) parsedStatus = TaskStatus.inProgress;
    else if (sString.contains('complet')) parsedStatus = TaskStatus.completed;
    else if (sString.contains('pus') || sString.contains('paus')) parsedStatus = TaskStatus.pused;

    // 4. Progress 0-100% er moddhe fixed kora
    double parsedProgress = 0.0;
    if (json['progress'] != null) {
      parsedProgress = double.tryParse(json['progress'].toString()) ?? 0.0;
      if (parsedProgress > 100) {
        parsedProgress = (parsedProgress % 100); // 9 digit number ke 2 digit e anbe
      }
      if (parsedProgress > 1.0) {
        parsedProgress = parsedProgress / 100; // 50 ke 0.50 te nibe
      }
      parsedProgress = parsedProgress.clamp(0.0, 1.0); // Jate 0 theke 1 er baire na jay
    }

    // 5. Dates
    DateTime parsedStartDate = DateTime.now();
    if (json['startDate'] != null) {
      parsedStartDate = DateTime.tryParse(json['startDate']) ?? DateTime.now();
    }

    DateTime parsedEndDate = DateTime.now().add(const Duration(days: 1));
    if (json['endDate'] != null) {
      parsedEndDate = DateTime.tryParse(json['endDate']) ?? parsedEndDate;
    }

    return Task(
      id: json['id']?.toString() ?? '',
      category: formattedCategory,
      title: json['title']?.toString() ?? '',
      progress: parsedProgress,
      startDate: parsedStartDate,
      endDate: parsedEndDate,
      priority: parsedPriority,
      status: parsedStatus,
    );
  }
  // App theke MockAPI te data pathanor jonno (Task ke JSON e convert)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      // API te 0.50 pathale seta 50 hishebe pathabe jate string hobe
      'progress': (progress * 100).toStringAsFixed(0),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'priority': priority.label,
      'status': status.label,
    };
  }
}

/// "12 Oct 2026"
String formatDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  // d.month theke 1 biyog hobe karon array 0 theke shuru hoy
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}