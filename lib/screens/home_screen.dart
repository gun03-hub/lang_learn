import 'package:flutter/material.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learning'),
      ),
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/language.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Content
          Container(
            color: Colors.black.withOpacity(0.3), // Optional: Add overlay
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Language Learning!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildMenuButton(
                    context,
                    'Start Lesson',
                    Icons.book,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LessonScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Take Quiz',
                    Icons.quiz,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'View Progress',
                    Icons.bar_chart,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProgressScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(title),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
