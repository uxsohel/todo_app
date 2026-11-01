import 'package:flutter/material.dart';

import '../core/app_text.dart';

/// "I don't Have an account? Signup" at the bottom of auth screens.
class AuthSwitchText extends StatelessWidget {
  const AuthSwitchText({
    super.key,
    required this.prefix,
    required this.action,
    required this.onTap,
  });

  final String prefix;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefix, style: AppText.body14),
        GestureDetector(
          onTap: onTap,
          child: Text(action, style: AppText.link14),
        ),
      ],
    );
  }
}
