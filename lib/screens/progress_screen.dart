import 'package:flutter/material.dart';
import '../models/language.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: languages.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Progress'),
          bottom: TabBar(
            tabs: languages
                .map((lang) => Tab(text: '${lang.flag} ${lang.name}'))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: languages.map((lang) => _buildLanguageProgress(lang)).toList(),
        ),
      ),
    );
  }

  Widget _buildLanguageProgress(Language language) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${language.name} Learning Progress',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildProgressCard('Words Learned', '20'),
          _buildProgressCard('Quizzes Completed', '5'),
          _buildProgressCard('Average Score', '85%'),
          const SizedBox(height: 20),
          _buildDetailedStats(language),
          const SizedBox(height: 20),
          _buildWeeklyProgress(),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedStats(Language language) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detailed Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProgressBar('Vocabulary', 0.7),
            _buildProgressBar('Grammar', 0.6),
            _buildProgressBar('Listening', 0.5),
            _buildProgressBar('Speaking', 0.4),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String skill, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Text('${(progress * 100).toInt()}%'),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                7,
                (index) => _buildDayActivity(
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  (index * 20 + 10).toDouble(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayActivity(String day, double height) {
    return Column(
      children: [
        Container(
          width: 20,
          height: height,
          color: Colors.blue,
        ),
        const SizedBox(height: 8),
        Text(day),
      ],
    );
  }
}