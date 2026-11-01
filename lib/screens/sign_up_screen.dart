import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../core/validators.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_switch_text.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_header.dart';
import '../widgets/social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _retype = TextEditingController();
  bool _agree = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _retype.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms and conditions')),
      );
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
              const ScreenHeader(title: 'Sign Up'),
              const SizedBox(height: 33),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'E-mail',
                          hint: 'Enter your email',
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          controller: _password,
                          isPassword: true,
                          validator: Validators.password,
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: 'Retype-Password',
                          hint: 'Retype your password',
                          controller: _retype,
                          isPassword: true,
                          validator: (v) => v != _password.text
                              ? 'Passwords do not match'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _agree,
                                activeColor: AppColors.primary,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                onChanged: (v) =>
                                    setState(() => _agree = v ?? false),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text('I Agree terms and Conditions',
                                style: AppText.small),
                          ],
                        ),
                        const SizedBox(height: 25),
                        PrimaryButton(label: 'Sign Up Now', onPressed: _signUp),
                        const SizedBox(height: 47),
                        Text('Or with', style: AppText.smallBold),
                        const SizedBox(height: 47),
                        const SocialButton(
                          label: 'Signup with Facebook',
                          icon: FacebookIcon(),
                          filled: true,
                        ),
                        const SizedBox(height: 10),
                        const SocialButton(
                          label: 'Signup with Google',
                          icon: GoogleIcon(),
                          filled: false,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              AuthSwitchText(
                prefix: 'Already Have an account? ',
                action: 'SignIn',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
