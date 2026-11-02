import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../core/validators.dart';
import '../data/api_service.dart'; // API Service ইম্পোর্ট করা হলো
import '../widgets/app_text_field.dart';
import '../widgets/auth_switch_text.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_header.dart';
import '../widgets/social_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _remember = false;

  bool _isLoading = false; // API কল চলার সময় লোডিং দেখানোর জন্য

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // ApiService এর মাধ্যমে ইমেইল এবং পাসওয়ার্ড চেক করা হচ্ছে
      final user = await ApiService().signInUser(
        _email.text.trim(),
        _password.text,
      );

      setState(() => _isLoading = false);

      if (user != null) {
        // লগইন সফল হলে হোম স্ক্রিনে যাবে
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        // ইমেইল বা পাসওয়ার্ড ভুল হলে এরর মেসেজ দেখাবে
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email or password. Please try again.')),
          );
        }
      }
    }
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
              const ScreenHeader(title: 'Sign In'),
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
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _remember,
                                activeColor: AppColors.primary,
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                onChanged: (v) =>
                                    setState(() => _remember = v ?? false),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text('Remember Password', style: AppText.small),
                            const Spacer(),
                            Text('Forgot Password?', style: AppText.link),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // লোডিং স্পিনার অথবা সাইন ইন বাটন
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : PrimaryButton(label: 'Sign In Now', onPressed: _signIn),
                        const SizedBox(height: 47),
                        Text('Or with', style: AppText.smallBold),
                        const SizedBox(height: 47),
                        const SocialButton(
                          label: 'Login with Facebook',
                          icon: FacebookIcon(),
                          filled: true,
                        ),
                        const SizedBox(height: 10),
                        const SocialButton(
                          label: 'Login with Google',
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
                prefix: 'I don’t Have an account? ',
                action: 'Signup',
                onTap: () => Navigator.pushNamed(context, '/signup'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}