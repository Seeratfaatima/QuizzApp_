import 'package:flutter/material.dart';
import 'quiz_data.dart'; // 1. Import the global data

class DiscoverQuizView extends StatelessWidget {
  const DiscoverQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if there are quizzes
    if (globalQuizzes.isEmpty) {
      return const Center(
        child: Text("No quizzes available yet."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: globalQuizzes.length,
      itemBuilder: (context, index) {
        final quiz = globalQuizzes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildQuizItem(
            icon: quiz['icon'] ?? Icons.article,
            title: quiz['title'] ?? 'Unknown',
            subtitle: quiz['subtitle'] ?? '',
            iconColor: quiz['iconColor'] ?? Colors.blue,
            iconBackgroundColor: quiz['bgColor'] ?? Colors.blue.shade50,
          ),
        );
      },
    );
  }

  // Helper widget to build the quiz card
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
}