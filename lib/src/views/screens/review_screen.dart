import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final Map<String, dynamic> quizContent;
  final Map<int, int> userAnswers; // Key: Question Index, Value: Selected Option Index

  const ReviewScreen({
    super.key,
    required this.quizContent,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final List questions = quizContent['questions'] ?? [];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Review Answers',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
            ),
            body: questions.isEmpty
                ? const Center(child: Text("No questions to review", style: TextStyle(color: Colors.white)))
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(questions.length, (index) {
                    final questionData = questions[index];
                    final int correctIndex = questionData['answer'];
                    final int? userSelectedIndex = userAnswers[index];
                    final List<String> options = List<String>.from(questionData['options']);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question Header
                        Text(
                          'Question ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Colors.yellowAccent.withOpacity(0.7),
                          thickness: 1,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          questionData['question'],
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 12.0),

                        // Logic to show Right/Wrong answers
                        if (userSelectedIndex == null)
                        // User skipped
                          _buildAnswerRow(
                            icon: Icons.info_outline,
                            text: "Skipped (Correct: ${options[correctIndex]})",
                            color: Colors.orangeAccent,
                          )
                        else if (userSelectedIndex == correctIndex)
                        // User was Correct
                          _buildAnswerRow(
                            icon: Icons.check_circle,
                            text: options[userSelectedIndex],
                            color: Colors.greenAccent.shade400,
                          )
                        else ...[
                            // User was Wrong (Show selected as Wrong, then Correct answer)
                            _buildAnswerRow(
                              icon: Icons.cancel,
                              text: options[userSelectedIndex],
                              color: Colors.redAccent.shade400,
                            ),
                            const SizedBox(height: 8),
                            _buildAnswerRow(
                              icon: Icons.check_circle,
                              text: options[correctIndex],
                              color: Colors.greenAccent.shade400,
                            ),
                          ],
                        const SizedBox(height: 24.0),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerRow({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}