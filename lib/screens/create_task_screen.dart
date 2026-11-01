import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../core/validators.dart';
import '../data/task_store.dart';
import '../models/task.dart';
import '../widgets/app_text_field.dart';
import '../widgets/pill_chip.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_header.dart';

/// EXTRA SCREEN 1 (not in the Figma file). Built with the same components.
class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _category = TextEditingController();
  final _description = TextEditingController();
  final _startCtrl = TextEditingController();
  final _endCtrl = TextEditingController();

  late DateTime _start;
  late DateTime _end;
  Priority _priority = Priority.medium;
  TaskStatus _status = TaskStatus.todo;

  @override
  void initState() {
    super.initState();
    _start = DateTime.now();
    _end = _start.add(const Duration(days: 7));
    _startCtrl.text = formatDate(_start);
    _endCtrl.text = formatDate(_end);
  }

  @override
  void dispose() {
    _title.dispose();
    _category.dispose();
    _description.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _start : _end,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _start = picked;
        if (_end.isBefore(_start)) _end = _start;
      } else {
        _end = picked;
      }
      _startCtrl.text = formatDate(_start);
      _endCtrl.text = formatDate(_end);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final messenger = ScaffoldMessenger.of(context);
    TaskStore.instance.add(
      Task(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        category: _category.text.trim(),
        title: _title.text.trim(),
        progress: _status == TaskStatus.completed ? 1 : 0,
        startDate: _start,
        endDate: _end,
        priority: _priority,
        status: _status,
      ),
    );
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(content: Text('Task created in "${_status.label}"')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const ScreenHeader(title: 'Create Task'),
              const SizedBox(height: 33),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          label: 'Task Title',
                          hint: 'Enter task title',
                          controller: _title,
                          validator: (v) => Validators.required(v, 'Title'),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: 'Category',
                          hint: 'e.g. Design',
                          controller: _category,
                          validator: (v) => Validators.required(v, 'Category'),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: 'Description',
                          hint: 'Write something about the task',
                          controller: _description,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AppTextField(
                                label: 'Start Date',
                                hint: 'Pick a date',
                                controller: _startCtrl,
                                readOnly: true,
                                onTap: () => _pickDate(isStart: true),
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppTextField(
                                label: 'End Date',
                                hint: 'Pick a date',
                                controller: _endCtrl,
                                readOnly: true,
                                onTap: () => _pickDate(isStart: false),
                                suffixIcon: const Icon(
                                  Icons.flag_outlined,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('Priority', style: AppText.label),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 11,
                          runSpacing: 10,
                          children: [
                            for (final p in Priority.values)
                              PillChip(
                                label: p.label,
                                selected: _priority == p,
                                onTap: () => setState(() => _priority = p),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('Status', style: AppText.label),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 11,
                          runSpacing: 10,
                          children: [
                            for (final s in TaskStatus.values)
                              PillChip(
                                label: s.label,
                                selected: _status == s,
                                onTap: () => setState(() => _status = s),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              PrimaryButton(label: 'Create Task', onPressed: _submit),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
