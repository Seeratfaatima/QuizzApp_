import 'package:flutter/material.dart';
import 'quiz_data.dart'; // Import the global data

class DiscoverCategoryView extends StatelessWidget {
  const DiscoverCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    if (globalCategories.isEmpty) {
      return const Center(child: Text("No categories available."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: globalCategories.length,
      itemBuilder: (context, index) {
        final category = globalCategories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildCategoryItem(
            icon: category['icon'] ?? Icons.category,
            title: category['title'] ?? 'Unknown',
            iconColor: category['iconColor'] ?? Colors.grey,
            iconBackgroundColor: category['bgColor'] ?? Colors.grey.shade200,
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String title,
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
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
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