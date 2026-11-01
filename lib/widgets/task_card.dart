import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  Color get _priorityColor => switch (task.priority) {
        Priority.high => AppColors.primary,
        Priority.medium => AppColors.purple,
        Priority.low => AppColors.green,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category + title + more button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.category, style: AppText.category),
                    Text(
                      task.title,
                      style: AppText.cardTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: const Icon(Icons.more_horiz,
                    size: 14, color: AppColors.icon),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress
          Text('Progress', style: AppText.smallGreyMedium),
          SizedBox(
            width: 175,
            child: Row(
              children: [
                _ProgressBar(value: task.progress),
                const Spacer(),
                Text('${(task.progress * 100).round()}%',
                    style: AppText.small),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Dates
          Row(
            children: [
              _IconText(
                  icon: Icons.calendar_today_outlined,
                  text: formatDate(task.startDate)),
              const SizedBox(width: 15),
              _IconText(
                  icon: Icons.flag_outlined, text: formatDate(task.endDate)),
            ],
          ),
          const SizedBox(height: 8),

          // Avatars + priority badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _AvatarStack(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
                decoration: BoxDecoration(
                  color: _priorityColor,
                  borderRadius: BorderRadius.circular(41),
                ),
                child: Text(task.priority.label, style: AppText.badge),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 144,
      height: 4,
      child: Stack(
        children: [
          Container(color: AppColors.track),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 5),
        Text(text, style: AppText.smallGrey),
      ],
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  Widget _circle({required Color color, required Widget child}) => Container(
        width: 29,
        height: 29,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 101,
      height: 29,
      child: Stack(
        children: [
          for (var i = 0; i < 4; i++)
            Positioned(
              left: i * 18.0,
              child: _circle(
                color: AppColors.track,
                child: const Icon(Icons.person, size: 16, color: Colors.white),
              ),
            ),
          Positioned(
            left: 72,
            child: _circle(
              color: AppColors.primary,
              child: const Icon(Icons.add, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
