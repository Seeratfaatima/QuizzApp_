import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  // Define the path to your background image
  static const String _backgroundImagePath = 'assets/images/background.png';

  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // 1. The Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_backgroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 2. The Scaffold for UI elements
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Navigate back to Dashboard
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Leaderboard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // --- Top 3 Players Section ---
              Container(
                height: screenHeight * 0.35,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 2nd Place
                    _buildTopPlayer(
                      name: 'Hira',
                      score: '8/10',
                      radius: 40,
                      icon: Icons.female,
                      color: Colors.pink[200]!,
                    ),
                    // 1st Place
                    _buildTopPlayer(
                      name: 'Seerat Fatima',
                      score: '9/10',
                      radius: 55,
                      icon: Icons.face_3,
                      color: Colors.purple[200]!,
                    ),
                    // 3rd Place
                    _buildTopPlayer(
                      name: 'Ali',
                      score: '7/10',
                      radius: 40,
                      icon: Icons.male,
                      color: Colors.blue[200]!,
                    ),
                  ],
                ),
              ),

              // --- Rest of the List Section ---
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 16.0),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        // Dummy data
                        final ranks = ['4', '5', '6', '7', '8'];
                        final names = [
                          'Smith Carol',
                          'Harry',
                          'Jon',
                          'Ken',
                          'Petter'
                        ];
                        final scores = [
                          '6/10',
                          '6/10',
                          '6/10',
                          '6/10',
                          '6/10'
                        ];
                        final colors = [
                          Colors.grey[400],
                          Colors.blue[300],
                          Colors.orange[300],
                          Colors.yellow[700],
                          Colors.brown[300]
                        ];

                        return _buildRankItem(
                          rank: ranks[index],
                          name: names[index],
                          score: scores[index],
                          icon: Icons.person,
                          color: colors[index]!,
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black12,
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopPlayer({
    required String name,
    required String score,
    required double radius,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: color,
          child: Icon(icon, size: radius, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          score,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRankItem({
    required String rank,
    required String name,
    required String score,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Text(
            rank,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 22,
            backgroundColor: color,
            child: Icon(icon, size: 22, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            score,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}