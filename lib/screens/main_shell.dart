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

  // HomeScreen রিফ্রেশ করার জন্য একটি ডাইনামিক Key
  Key _homeKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    // List-টি build মেথডের ভেতরে রাখা হলো, যাতে Key আপডেট হলে এটি নতুন করে তৈরি হয়
    final List<Widget> pages = [
      HomeScreen(key: _homeKey), // এখানে Key বসানো হয়েছে
      const _ComingSoon(title: 'Calendar'),
      const _ComingSoon(title: 'Statistics'),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        onAddTap: () async {
          // Navigator.pushNamed-কে await করা হলো
          final result = await Navigator.pushNamed(context, '/create-task');

          // ক্রিয়েট স্ক্রিন থেকে true রিটার্ন করলে (মানে নতুন টাস্ক তৈরি হলে)
          if (result == true) {
            setState(() {
              // Key পরিবর্তন করে দিলে HomeScreen ফোর্স-রিবিল্ড হবে এবং API নতুন করে কল হবে
              _homeKey = UniqueKey();
            });
          }
        },
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