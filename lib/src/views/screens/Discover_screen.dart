import 'package:flutter/material.dart';
import 'discover_quiz.dart';
import 'discover_category.dart'; // 1. Import the new Category View

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Start at Index 2 ("Categories") as requested
    _tabController = TabController(length: 4, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
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
              _buildSearchBar(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: _buildTabsContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 8),
            const Text(
              "Discover",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF6FE0D0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.white),
          hintText: "Ma...",
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTabsContent() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFF6FE0D0), width: 4),
            insets: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, -2.0),
          ),
          indicatorColor: Colors.transparent,
          tabs: const [
            Tab(text: "Top"),
            Tab(text: "Quiz"),
            Tab(text: "Categories"),
            Tab(text: "Friends"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // 1. Top Tab
              _buildTopTabContent(),

              // 2. Quiz Tab
              const DiscoverQuizView(),

              // 3. Categories Tab (Connected to discover_category.dart)
              const DiscoverCategoryView(),

              // 4. Friends Tab
              _buildFriendsTabContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopTabContent() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Quiz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                _tabController.animateTo(1);
              },
              child: const Text(
                "See all",
                style: TextStyle(
                  color: Color(0xFF6A5ACD),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildQuizItem(
          icon: Icons.bar_chart,
          title: "Statistics Math Quiz",
          subtitle: "Math • 12 Quizzes",
          iconColor: const Color(0xFF4169E1),
          iconBackgroundColor: const Color(0xFFE0E7FF),
        ),
        const SizedBox(height: 16),
        _buildQuizItem(
          icon: Icons.grid_view_outlined,
          title: "Flutter Quiz",
          subtitle: "programming • 5 Quizzes",
          iconColor: const Color(0xFFD982A3),
          iconBackgroundColor: const Color(0xFFFCE8EF),
        ),
        const SizedBox(height: 24),
        const Text(
          "Friends",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildFriendItem(
          name: "Nida Naveed",
          points: "325 points",
          avatarColor: Colors.purple.shade100,
        ),
      ],
    );
  }

  Widget _buildFriendsTabContent() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          "Friends",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildFriendItem(
          name: "Nida Naveed",
          points: "325 points",
          avatarColor: Colors.purple.shade100,
        ),
        const SizedBox(height: 12),
        _buildFriendItem(
          name: "Ali Ahmad",
          points: "124 points",
          avatarColor: Colors.orange.shade100,
          avatarIcon: Icons.person_outline,
        ),
        const SizedBox(height: 12),
        _buildFriendItem(
          name: "Hira Zubair",
          points: "437 points",
          avatarColor: Colors.purple.shade100,
        ),
      ],
    );
  }

  Widget _buildQuizItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBackgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: iconColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem({
    required String name,
    required String points,
    required Color avatarColor,
    IconData avatarIcon = Icons.person,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: avatarColor,
          child: Icon(
            avatarIcon,
            size: 30,
            color: const Color(0xFF6A5ACD),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                points,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}