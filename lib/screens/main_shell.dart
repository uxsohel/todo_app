import 'package:flutter/material.dart';

import '../core/app_text.dart';
import '../widgets/app_bottom_nav.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// Holds the bottom navigation and switches between the tabs.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    _ComingSoon(title: 'Calendar'),
    _ComingSoon(title: 'Statistics'),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        onAddTap: () => Navigator.pushNamed(context, '/create-task'),
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$title (coming soon)', style: AppText.title));
  }
}
