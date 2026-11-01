import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../data/task_store.dart';
import '../models/task.dart';
import '../widgets/screen_header.dart';

/// EXTRA SCREEN 2 (not in the Figma file). Lives inside the bottom nav (Profile tab).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const ScreenHeader(title: 'Profile', showBack: false),
              const SizedBox(height: 24),
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: AppColors.track,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text('Sarthak', style: AppText.title),
              Text('sarthak121@gmail.com', style: AppText.smallGrey),
              const SizedBox(height: 24),

              // Task counts, live from TaskStore
              ListenableBuilder(
                listenable: TaskStore.instance,
                builder: (context, _) {
                  final store = TaskStore.instance;
                  return Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          value: store.countBy(TaskStatus.inProgress),
                          label: 'In progress',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatBox(
                          value: store.countBy(TaskStatus.todo),
                          label: 'To Do',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatBox(
                          value: store.countBy(TaskStatus.completed),
                          label: 'Completed',
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              const _MenuTile(icon: Icons.person_outline, title: 'Edit Profile'),
              const _MenuTile(
                  icon: Icons.notifications_none, title: 'Notifications'),
              const _MenuTile(icon: Icons.settings_outlined, title: 'Settings'),
              const _MenuTile(icon: Icons.help_outline, title: 'Help & Support'),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/signin', (route) => false),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text('Sign Out', style: AppText.link14),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          Text('$value',
              style: AppText.title.copyWith(color: AppColors.primary)),
          Text(label, style: AppText.smallGrey),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // TODO: practice task, navigate to each page
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Icon(icon, size: 18, color: AppColors.icon),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: AppText.label)),
            const Icon(Icons.chevron_right, color: AppColors.chipText),
          ],
        ),
      ),
    );
  }
}
