import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';

/// Filter chip: selected = solid blue, unselected = thin grey border.
class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: selected
              ? null
              : Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Text(
          label,
          style: AppText.chip
              .copyWith(color: selected ? Colors.white : AppColors.chipText),
        ),
      ),
    );
  }
}
