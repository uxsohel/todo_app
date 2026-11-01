import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';

/// Label on top, grey filled field below (44px high, radius 5) like Figma.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  OutlineInputBorder _border([Color color = Colors.transparent]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    Widget? suffix = widget.suffixIcon;
    if (widget.isPassword) {
      suffix = GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 14),
          child: Icon(
            _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 24,
            color: AppColors.icon,
          ),
        ),
      );
    } else if (suffix != null) {
      suffix = Padding(
        padding: const EdgeInsets.only(left: 8, right: 14),
        child: suffix,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppText.label),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style: AppText.input,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.inputBg,
            hintText: widget.hint,
            hintStyle: AppText.hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 11.5),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.red),
            focusedErrorBorder: _border(Colors.red),
            suffixIcon: suffix,
            suffixIconConstraints:
                const BoxConstraints(minHeight: 24, minWidth: 24),
          ),
        ),
      ],
    );
  }
}
