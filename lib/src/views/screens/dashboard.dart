import 'package:flutter/material.dart';
import 'profile.dart';
import 'Discover_screen.dart';
import 'leaderboard.dart';
import 'quiz_data.dart';
import 'quiz_screen.dart'; // Import Quiz Screen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaderboardScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } else {
      setState(() { _selectedIndex = index; });
    }
  }

  // ... (buildTopHeader, buildBottomNav etc remain same) ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Container(
            height: 350,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              _buildTopHeader(),
              _buildRecentQuizCard(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: _buildLiveQuizzesList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () { Navigator.pop(context); },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFE6E6FA),
                    child: Icon(Icons.person, size: 30, color: Color(0xFF6A5ACD)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Icon(Icons.wb_sunny_outlined, color: Colors.white70, size: 18),
                SizedBox(width: 8),
                Text("GOOD MORNING", style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Seerat", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentQuizCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFEC9E0), Color(0xFFFAAFCA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("RECENT QUIZ", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Text("Flutter Quiz", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(
            width: 55,
            height: 55,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(value: 0.65, color: Colors.white),
                Text("65%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveQuizzesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 10),
          child: Text("Live Quizzes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: globalQuizzes.length,
            itemBuilder: (context, index) {
              final quiz = globalQuizzes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                // --- THIS IS THE FIX: WRAP IN GESTURE DETECTOR ---
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(quizContent: quiz),
                      ),
                    );
                  },
                  child: _buildQuizItem(
                    icon: quiz['icon'] ?? Icons.article,
                    title: quiz['title'] ?? 'Unknown',
                    subtitle: quiz['subtitle'] ?? '',
                    iconColor: quiz['iconColor'] ?? Colors.blue,
                    iconBackgroundColor: quiz['bgColor'] ?? Colors.blue.shade50,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuizItem({required IconData icon, required String title, required String subtitle, required Color iconColor, required Color iconBackgroundColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconBackgroundColor, borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: iconColor, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: iconColor, size: 16),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF6A5ACD),
        unselectedItemColor: Colors.grey.shade400,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}