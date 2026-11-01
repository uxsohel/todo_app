import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Home, Calendar, [ + ], Chart, Profile.
/// currentIndex: 0 home, 1 calendar, 2 chart, 3 profile (the + button is not a tab).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;

  Widget _item(int index, IconData icon, IconData activeIcon) {
    final active = currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          active ? activeIcon : icon,
          size: 24,
          color: active ? AppColors.primary : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 69,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _item(0, Icons.home_outlined, Icons.home_rounded),
                _item(1, Icons.calendar_today_outlined, Icons.calendar_today),
                GestureDetector(
                  onTap: onAddTap,
                  child: Container(
                    width: 53,
                    height: 53,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
                _item(2, Icons.bar_chart_outlined, Icons.bar_chart_rounded),
                _item(3, Icons.person_outline, Icons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
