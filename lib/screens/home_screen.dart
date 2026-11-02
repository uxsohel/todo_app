import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../data/task_store.dart';
import '../models/task.dart';
import '../widgets/pill_chip.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskStatus _filter = TaskStatus.inProgress;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 10),
            _SearchBar(onChanged: (v) => setState(() => _query = v)),
            const SizedBox(height: 10),
            Text('Your Task', style: AppText.title),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < TaskStatus.values.length; i++) ...[
                    PillChip(
                      label: TaskStatus.values[i].label,
                      selected: _filter == TaskStatus.values[i],
                      onTap: () =>
                          setState(() => _filter = TaskStatus.values[i]),
                    ),
                    if (i < TaskStatus.values.length - 1)
                      const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListenableBuilder(
                listenable: TaskStore.instance,
                builder: (context, _) {
                  final q = _query.trim().toLowerCase();
                  final tasks = TaskStore.instance.tasks.where((t) {
                    final matchesStatus = t.status == _filter;
                    final matchesQuery = q.isEmpty ||
                        t.title.toLowerCase().contains(q) ||
                        t.category.toLowerCase().contains(q);
                    return matchesStatus && matchesQuery;
                  }).toList();

                  if (tasks.isEmpty) {
                    return Center(
                      child: Text('No tasks found', style: AppText.smallGrey),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => TaskCard(task: tasks[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: AppColors.track,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 7),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello',
                style: AppText.small.copyWith(color: AppColors.helloGrey),
              ),
              Text('Sohel', style: AppText.title),
            ],
          ),
          const Spacer(),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: const Icon(Icons.menu, size: 14, color: AppColors.icon),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        onChanged: onChanged,
        style: AppText.small,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.inputBg,
          hintText: 'Find your task here..',
          hintStyle: AppText.small.copyWith(color: AppColors.searchHint),
          prefixIcon: const Icon(Icons.search,
              size: 20, color: AppColors.searchIcon),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
