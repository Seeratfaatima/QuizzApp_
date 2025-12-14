import 'package:flutter/material.dart';
import 'addQuestionn_screen.dart';
import 'quiz_data.dart'; // Ensure you have imported this

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // We rely on 'globalQuizzes' from quiz_data.dart

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF2c2c2c),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3a3a3a),
          elevation: 0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'ADMIN DASHBOARD',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: ListView.builder(
            itemCount: globalQuizzes.length,
            itemBuilder: (context, index) {
              return _buildQuizCard(globalQuizzes[index]);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddQuizDialog(context);
          },
          backgroundColor: const Color(0xFF26E3BA),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Map<String, dynamic> quizInfo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF3e3e3e),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.book, color: Colors.white, size: 28),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizInfo['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quizInfo['subtitle'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              setState(() {
                globalQuizzes.remove(quizInfo);
              });
            },
          ),
        ],
      ),
    );
  }

  void _showAddQuizDialog(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController subtitleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          backgroundColor: const Color(0xFFE0E0E0),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Add Quiz",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: categoryController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Enter the category name",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: subtitleController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Enter the Subtitle",
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDialogButton("cancel", () {
                      Navigator.pop(context);
                    }),

                    // --- SAVE DATA LOGIC ---
                    _buildDialogButton("create", () async {
                      // 1. Get info
                      String title = categoryController.text;
                      String subtitle = subtitleController.text;
                      if(title.isEmpty) title = "New Quiz";

                      // 2. Close Dialog
                      Navigator.pop(context);

                      // 3. Navigate to Add Question and WAIT for result
                      final newQuestionData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddQuestionScreen(
                            categoryTitle: title,
                          ),
                        ),
                      );

                      // 4. If we got data back, save it to global list
                      if (newQuestionData != null) {
                        setState(() {
                          globalQuizzes.add({
                            'title': title,
                            'subtitle': subtitle.isNotEmpty ? subtitle : 'General',
                            'icon': Icons.star, // Default icon
                            'iconColor': const Color(0xFF4169E1),
                            'bgColor': const Color(0xFFE0E7FF),
                            // IMPORTANT: Save the question inside the list
                            'questions': [ newQuestionData ],
                          });
                        });
                      }
                    }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF26E3BA),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}