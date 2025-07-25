import 'package:flutter/material.dart';
import '../models/language.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  String? selectedLanguage;
  int currentIndex = 0;
  bool lessonStarted = false;

  final Map<String, List<Map<String, String>>> languageWords = {
    'es': [
      {'word': 'Hello', 'translation': 'Hola'},
      {'word': 'Goodbye', 'translation': 'Adiós'},
      {'word': 'Thank you', 'translation': 'Gracias'},
      {'word': 'Please', 'translation': 'Por favor'},
      {'word': 'Good morning', 'translation': 'Buenos días'},
      {'word': 'Good night', 'translation': 'Buenas noches'},
    ],
    'fr': [
      {'word': 'Hello', 'translation': 'Bonjour'},
      {'word': 'Goodbye', 'translation': 'Au revoir'},
      {'word': 'Thank you', 'translation': 'Merci'},
      {'word': 'Please', 'translation': 'S\'il vous plaît'},
      {'word': 'Good morning', 'translation': 'Bonjour'},
      {'word': 'Good night', 'translation': 'Bonne nuit'},
    ],
    'ja': [
      {'word': 'Hello', 'translation': 'こんにちは'},
      {'word': 'Goodbye', 'translation': 'さようなら'},
      {'word': 'Thank you', 'translation': 'ありがとう'},
      {'word': 'Please', 'translation': 'お願いします'},
      {'word': 'Good morning', 'translation': 'おはようございます'},
      {'word': 'Good night', 'translation': 'おやすみなさい'},
    ],
  };

  List<Map<String, String>> get words => 
      languageWords[selectedLanguage] ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Words'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !lessonStarted
            ? _buildLanguageSelection()
            : _buildLessonContent(),
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Select a Language to Learn',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        ...languages.map((language) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedLanguage = language.code;
                      lessonStarted = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        language.flag,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        language.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildLessonContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    words[currentIndex]['word']!,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    words[currentIndex]['translation']!,
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (currentIndex > 0) {
                    setState(() {
                      currentIndex--;
                    });
                  }
                },
                child: const Text('Previous'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  if (currentIndex < words.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}