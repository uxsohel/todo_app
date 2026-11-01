import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'core/app_colors.dart';
import 'screens/create_task_screen.dart';
import 'screens/main_shell.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)
            .copyWith(primary: AppColors.primary, surface: Colors.white),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/signin': (_) => const SignInScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/home': (_) => const MainShell(),
        '/create-task': (_) => const CreateTaskScreen(),
      },
    );
  }
}
