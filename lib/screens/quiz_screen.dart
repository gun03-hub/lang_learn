import 'package:flutter/material.dart';
import '../models/language.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool showOverlay = false;
  String? selectedLanguage;
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizStarted = false;
  bool quizCompleted = false;
  bool? isCorrect; // Add this new state variable
  Map<int, bool> answeredQuestions = {};  // Track answered questions
  Map<int, String> selectedAnswers = {};  // Track selected answers
  int questionTimeInSeconds = 3;  // Increased visibility time for answers

  final Map<String, List<Map<String, dynamic>>> languageQuestions = {
    'es': [
      {
        'question': 'What is "Hello" in Spanish?',
        'options': ['Hola', 'Adiós', 'Gracias', 'Por favor'],
        'correctAnswer': 'Hola',
      },
      {
        'question': 'What is "Good morning" in Spanish?',
        'options': ['Buenas noches', 'Buenos días', 'Gracias', 'Hola'],
        'correctAnswer': 'Buenos días',
      },
      {
        'question': 'What is "Good night" in Spanish?',
        'options': ['Buenos días', 'Buenas tardes', 'Buenas noches', 'Adiós'],
        'correctAnswer': 'Buenas noches',
      },
      {
        'question': 'How do you say "Please" in Spanish?',
        'options': ['Gracias', 'Por favor', 'De nada', 'Perdón'],
        'correctAnswer': 'Por favor',
      },
      {
        'question': 'What is "Thank you" in Spanish?',
        'options': ['Por favor', 'De nada', 'Gracias', 'Perdón'],
        'correctAnswer': 'Gracias',
      },
      {
        'question': 'How do you say "You\'re welcome" in Spanish?',
        'options': ['Por favor', 'De nada', 'Gracias', 'Perdón'],
        'correctAnswer': 'De nada',
      },
      {
        'question': 'What is "Sorry" in Spanish?',
        'options': ['Por favor', 'De nada', 'Gracias', 'Perdón'],
        'correctAnswer': 'Perdón',
      },
      {
        'question': 'How do you say "Water" in Spanish?',
        'options': ['Pan', 'Agua', 'Leche', 'Café'],
        'correctAnswer': 'Agua',
      },
      {
        'question': 'What is "Food" in Spanish?',
        'options': ['Comida', 'Bebida', 'Cena', 'Almuerzo'],
        'correctAnswer': 'Comida',
      },
      {
        'question': 'How do you say "Yes" in Spanish?',
        'options': ['No', 'Tal vez', 'Sí', 'Quizás'],
        'correctAnswer': 'Sí',
      },
      {
        'question': 'What is "No" in Spanish?',
        'options': ['Sí', 'Tal vez', 'No', 'Quizás'],
        'correctAnswer': 'No',
      },
      {
        'question': 'How do you say "Friend" in Spanish?',
        'options': ['Amigo', 'Enemigo', 'Familia', 'Hermano'],
        'correctAnswer': 'Amigo',
      },
      {
        'question': 'What is "Family" in Spanish?',
        'options': ['Amigo', 'Casa', 'Familia', 'Trabajo'],
        'correctAnswer': 'Familia',
      },
      {
        'question': 'How do you say "House" in Spanish?',
        'options': ['Carro', 'Casa', 'Jardín', 'Puerta'],
        'correctAnswer': 'Casa',
      },
      {
        'question': 'What is "Time" in Spanish?',
        'options': ['Día', 'Hora', 'Tiempo', 'Minuto'],
        'correctAnswer': 'Tiempo',
      },
    ],
    'fr': [
      {
        'question': 'What is "Hello" in French?',
        'options': ['Bonjour', 'Au revoir', 'Merci', 'S\'il vous plaît'],
        'correctAnswer': 'Bonjour',
      },
      {
        'question': 'What is "Goodbye" in French?',
        'options': ['Bonjour', 'Au revoir', 'Merci', 'S\'il vous plaît'],
        'correctAnswer': 'Au revoir',
      },
      {
        'question': 'How do you say "Please" in French?',
        'options': ['Merci', 'De rien', 'S\'il vous plaît', 'Pardon'],
        'correctAnswer': 'S\'il vous plaît',
      },
      {
        'question': 'What is "Thank you" in French?',
        'options': ['Bonjour', 'Au revoir', 'Merci', 'S\'il vous plaît'],
        'correctAnswer': 'Merci',
      },
      {
        'question': 'How do you say "You\'re welcome" in French?',
        'options': ['Merci', 'De rien', 'S\'il vous plaît', 'Pardon'],
        'correctAnswer': 'De rien',
      },
      {
        'question': 'What is "Good morning" in French?',
        'options': ['Bonsoir', 'Bonjour', 'Bonne nuit', 'Au revoir'],
        'correctAnswer': 'Bonjour',
      },
      {
        'question': 'How do you say "Good night" in French?',
        'options': ['Bonsoir', 'Bonjour', 'Bonne nuit', 'Au revoir'],
        'correctAnswer': 'Bonne nuit',
      },
      {
        'question': 'What is "Water" in French?',
        'options': ['Pain', 'Eau', 'Lait', 'Café'],
        'correctAnswer': 'Eau',
      },
      {
        'question': 'How do you say "Food" in French?',
        'options': ['Nourriture', 'Boisson', 'Dîner', 'Déjeuner'],
        'correctAnswer': 'Nourriture',
      },
      {
        'question': 'What is "Yes" in French?',
        'options': ['Non', 'Peut-être', 'Oui', 'Parfois'],
        'correctAnswer': 'Oui',
      },
      {
        'question': 'How do you say "No" in French?',
        'options': ['Oui', 'Peut-être', 'Non', 'Parfois'],
        'correctAnswer': 'Non',
      },
      {
        'question': 'What is "Friend" in French?',
        'options': ['Ami', 'Ennemi', 'Famille', 'Frère'],
        'correctAnswer': 'Ami',
      },
      {
        'question': 'How do you say "Family" in French?',
        'options': ['Ami', 'Maison', 'Famille', 'Travail'],
        'correctAnswer': 'Famille',
      },
      {
        'question': 'What is "House" in French?',
        'options': ['Voiture', 'Maison', 'Jardin', 'Porte'],
        'correctAnswer': 'Maison',
      },
      {
        'question': 'How do you say "Time" in French?',
        'options': ['Jour', 'Heure', 'Temps', 'Minute'],
        'correctAnswer': 'Temps',
      },
    ],
    'ja': [
      {
        'question': 'What is "Hello" in Japanese?',
        'options': ['こんにちは', 'さようなら', 'ありがとう', 'お願いします'],
        'correctAnswer': 'こんにちは',
      },
      {
        'question': 'What is "Goodbye" in Japanese?',
        'options': ['こんにちは', 'さようなら', 'ありがとう', 'お願いします'],
        'correctAnswer': 'さようなら',
      },
      {
        'question': 'How do you say "Please" in Japanese?',
        'options': ['ありがとう', 'どういたしまして', 'お願いします', 'すみません'],
        'correctAnswer': 'お願いします',
      },
      {
        'question': 'What is "Thank you" in Japanese?',
        'options': ['こんにちは', 'さようなら', 'ありがとう', 'お願いします'],
        'correctAnswer': 'ありがとう',
      },
      {
        'question': 'How do you say "You\'re welcome" in Japanese?',
        'options': ['ありがとう', 'どういたしまして', 'お願いします', 'すみません'],
        'correctAnswer': 'どういたしまして',
      },
      {
        'question': 'What is "Good morning" in Japanese?',
        'options': ['こんばんは', 'おはようございます', 'おやすみなさい', 'さようなら'],
        'correctAnswer': 'おはようございます',
      },
      {
        'question': 'How do you say "Good night" in Japanese?',
        'options': ['こんばんは', 'おはようございます', 'おやすみなさい', 'さようなら'],
        'correctAnswer': 'おやすみなさい',
      },
      {
        'question': 'What is "Water" in Japanese?',
        'options': ['パン', '水', '牛乳', 'コーヒー'],
        'correctAnswer': '水',
      },
      {
        'question': 'How do you say "Food" in Japanese?',
        'options': ['食べ物', '飲み物', '夕食', '昼食'],
        'correctAnswer': '食べ物',
      },
      {
        'question': 'What is "Yes" in Japanese?',
        'options': ['いいえ', 'たぶん', 'はい', 'ときどき'],
        'correctAnswer': 'はい',
      },
      {
        'question': 'How do you say "No" in Japanese?',
        'options': ['はい', 'たぶん', 'いいえ', 'ときどき'],
        'correctAnswer': 'いいえ',
      },
      {
        'question': 'What is "Friend" in Japanese?',
        'options': ['友達', '敵', '家族', '兄弟'],
        'correctAnswer': '友達',
      },
      {
        'question': 'How do you say "Family" in Japanese?',
        'options': ['友達', '家', '家族', '仕事'],
        'correctAnswer': '家族',
      },
      {
        'question': 'What is "House" in Japanese?',
        'options': ['車', '家', '庭', 'ドア'],
        'correctAnswer': '家',
      },
      {
        'question': 'How do you say "Time" in Japanese?',
        'options': ['日', '時間', '時', '分'],
        'correctAnswer': '時間',
      },
    ],
    'de': [
      {
        'question': 'What is "Hello" in German?',
        'options': ['Hallo', 'Tschüss', 'Danke', 'Bitte'],
        'correctAnswer': 'Hallo',
      },
      {
        'question': 'What is "Goodbye" in German?',
        'options': ['Hallo', 'Tschüss', 'Auf Wiedersehen', 'Danke'],
        'correctAnswer': 'Tschüss',
      },
      {
        'question': 'How do you say "Please" in German?',
        'options': ['Merci', 'De rien', 'S\'il vous plaît', 'Pardon'],
        'correctAnswer': 'S\'il vous plaît',
      },
      {
        'question': 'What is "Thank you" in German?',
        'options': ['Bonjour', 'Au revoir', 'Merci', 'S\'il vous plaît'],
        'correctAnswer': 'Merci',
      },
      {
        'question': 'How do you say "You\'re welcome" in German?',
        'options': ['Merci', 'De rien', 'S\'il vous plaît', 'Pardon'],
        'correctAnswer': 'De rien',
      },
      {
        'question': 'What is "Good morning" in German?',
        'options': ['Bonsoir', 'Bonjour', 'Bonne nuit', 'Au revoir'],
        'correctAnswer': 'Bonjour',
      },
      {
        'question': 'How do you say "Good night" in German?',
        'options': ['Bonsoir', 'Bonjour', 'Bonne nuit', 'Au revoir'],
        'correctAnswer': 'Bonne nuit',
      },
      {
        'question': 'What is "Water" in German?',
        'options': ['Pain', 'Eau', 'Lait', 'Café'],
        'correctAnswer': 'Eau',
      },
      {
        'question': 'How do you say "Food" in German?',
        'options': ['Nourriture', 'Boisson', 'Dîner', 'Déjeuner'],
        'correctAnswer': 'Nourriture',
      },
      {
        'question': 'What is "Yes" in German?',
        'options': ['Non', 'Peut-être', 'Oui', 'Parfois'],
        'correctAnswer': 'Oui',
      },
      {
        'question': 'How do you say "No" in German?',
        'options': ['Oui', 'Peut-être', 'Non', 'Parfois'],
        'correctAnswer': 'Non',
      },
      {
        'question': 'What is "Friend" in German?',
        'options': ['Ami', 'Ennemi', 'Famille', 'Frère'],
        'correctAnswer': 'Ami',
      },
      {
        'question': 'How do you say "Family" in German?',
        'options': ['Ami', 'Maison', 'Famille', 'Travail'],
        'correctAnswer': 'Famille',
      },
      {
        'question': 'What is "House" in German?',
        'options': ['Voiture', 'Maison', 'Jardin', 'Porte'],
        'correctAnswer': 'Maison',
      },
      {
        'question': 'How do you say "Time" in German?',
        'options': ['Jour', 'Heure', 'Temps', 'Minute'],
        'correctAnswer': 'Temps',
      },
    ],
    'it': [
      {
        'question': 'What is "Hello" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Ciao',
      },
      {
        'question': 'What is "Goodbye" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Arrivederci',
      },
      {
        'question': 'How do you say "Please" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Ciao',
      },
      {
        'question': 'What is "Thank you" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Ciao',
      },
      {
        'question': 'How do you say "You\'re welcome" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Ciao',
      },
      {
        'question': 'What is "Good morning" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Ciao',
      },
      {
        'question': 'How do you say "Good night" in Italian?',
        'options': ['Ciao', 'Arrivederci', 'Grazie', 'Per favore'],
        'correctAnswer': 'Ciao',
      },
      {
        'question': 'What is "Water" in Italian?',
        'options': ['Pain', 'Eau', 'Lait', 'Café'],
        'correctAnswer': 'Eau',
      },
      {
        'question': 'How do you say "Food" in Italian?',
        'options': ['Nourriture', 'Boisson', 'Dîner', 'Déjeuner'],
        'correctAnswer': 'Nourriture',
      },
      {
        'question': 'What is "Yes" in Italian?',
        'options': ['Non', 'Peut-être', 'Oui', 'Parfois'],
        'correctAnswer': 'Oui',
      },
      {
        'question': 'How do you say "No" in Italian?',
        'options': ['Oui', 'Peut-être', 'Non', 'Parfois'],
        'correctAnswer': 'Non',
      },
      {
        'question': 'What is "Friend" in Italian?',
        'options': ['Ami', 'Ennemi', 'Famille', 'Frère'],
        'correctAnswer': 'Ami',
      },
      {
        'question': 'How do you say "Family" in Italian?',
        'options': ['Ami', 'Maison', 'Famille', 'Travail'],
        'correctAnswer': 'Famille',
      },
      {
        'question': 'What is "House" in Italian?',
        'options': ['Voiture', 'Maison', 'Jardin', 'Porte'],
        'correctAnswer': 'Maison',
      },
      {
        'question': 'How do you say "Time" in Italian?',
        'options': ['Jour', 'Heure', 'Temps', 'Minute'],
        'correctAnswer': 'Temps',
      },
    ],
    'ko': [
      {
        'question': 'What is "Hello" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "Goodbye" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕히 가세요',
      },
      {
        'question': 'How do you say "Please" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "Thank you" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'How do you say "You\'re welcome" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "Good morning" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'How do you say "Good night" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "Water" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'How do you say "Food" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "Yes" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'How do you say "No" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "Friend" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'How do you say "Family" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'What is "House" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
      {
        'question': 'How do you say "Time" in Korean?',
        'options': ['안녕하세요', '감사합니다', '안녕히 가세요', '부탁합니다'],
        'correctAnswer': '안녕하세요',
      },
    ],
  };

  List<Map<String, dynamic>> get questions => 
      languageQuestions[selectedLanguage] ?? [];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedLanguage != null 
              ? 'Quiz - ${languages.firstWhere((l) => l.code == selectedLanguage).name}'
              : 'Language Quiz',
        ),
        backgroundColor: Colors.blue.withOpacity(0.8),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/language_bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.lighten,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: !quizStarted
                ? _buildLanguageSelection()
                : quizCompleted
                    ? _buildQuizComplete()
                    : _buildQuizQuestion(),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String selectedAnswer) {
    if (quizCompleted) return;

    bool correct = selectedAnswer == questions[currentQuestionIndex]['correctAnswer'];
    setState(() {
      isCorrect = correct;
      showOverlay = true;
      if (correct && !answeredQuestions.containsKey(currentQuestionIndex)) {
        score++;
        _audioPlayer.play(AssetSource('sounds/correct.mp3')); // Updated path
      } else {
        _audioPlayer.play(AssetSource('sounds/incorrect.mp3')); // Updated path
      }
      answeredQuestions[currentQuestionIndex] = correct;
      selectedAnswers[currentQuestionIndex] = selectedAnswer;
    });

    Future.delayed(Duration(seconds: questionTimeInSeconds), () {
      if (!mounted) return;
      setState(() {
        showOverlay = false;
      });
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          isCorrect = null;
        });
      } else {
        setState(() {
          quizCompleted = true;
        });
      }
    });
  }

  Widget _buildQuizQuestion() {
    bool isAnswered = answeredQuestions.containsKey(currentQuestionIndex);
    String? selectedAnswer = selectedAnswers[currentQuestionIndex];
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / questions.length,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 10),
          // Question counter with score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'Score: $score',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Question
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                questions[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Options
          ...(questions[currentQuestionIndex]['options'] as List<String>)
              .map((option) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getButtonColor(option, isAnswered),
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: isAnswered ? null : () => checkAnswer(option),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ))
              .toList(),
          if (isAnswered) ...[
            const SizedBox(height: 20),
            Card(
              color: answeredQuestions[currentQuestionIndex]! 
                  ? Colors.green.shade50 
                  : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      answeredQuestions[currentQuestionIndex]! 
                          ? '✓ Correct!' 
                          : '✗ Incorrect!',
                      style: TextStyle(
                        fontSize: 18,
                        color: answeredQuestions[currentQuestionIndex]! 
                            ? Colors.green 
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Correct answer: ${questions[currentQuestionIndex]['correctAnswer']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                onPressed: currentQuestionIndex > 0
                    ? () {
                        setState(() {
                          currentQuestionIndex--;
                          isCorrect = answeredQuestions[currentQuestionIndex];
                        });
                      }
                    : null,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
                onPressed: currentQuestionIndex < questions.length - 1
                    ? () {
                        setState(() {
                          currentQuestionIndex++;
                          isCorrect = answeredQuestions[currentQuestionIndex];
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getButtonColor(String option, bool isAnswered) {  // Updated method signature
      if (!isAnswered) return Colors.blue;
      
      final correctAnswer = questions[currentQuestionIndex]['correctAnswer'];
      if (option == correctAnswer) {
        return Colors.green;
      } else if (option == selectedAnswers[currentQuestionIndex]) {
        return Colors.red;
      }
      return Colors.blue.withOpacity(0.7);
    }

  // Remove the second build method (around line 694)
  // Delete this duplicate build method
  Widget _buildLanguageSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Select a Language',
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
                      quizStarted = true;
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

  Widget _buildQuizComplete() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Quiz Complete!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your Score: $score/${questions.length}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${(score / questions.length * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 20,
                      color: score > questions.length / 2 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Response Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              bool? isCorrect = answeredQuestions[index];
              String? selectedAnswer = selectedAnswers[index];
              String correctAnswer = questions[index]['correctAnswer'];
              
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: isCorrect == true 
                    ? Colors.green.shade50 
                    : Colors.red.shade50,
                child: ListTile(
                  leading: Icon(
                    isCorrect == true ? Icons.check_circle : Icons.cancel,
                    color: isCorrect == true ? Colors.green : Colors.red,
                  ),
                  title: Text(questions[index]['question']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your answer: ${selectedAnswer ?? 'Not answered'}'),
                      if (isCorrect == false)
                        Text(
                          'Correct answer: $correctAnswer',
                          style: const TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    quizCompleted = false;
                    answeredQuestions.clear();
                    selectedAnswers.clear();
                    isCorrect = null;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Quiz'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    selectedLanguage = null;
                    currentQuestionIndex = 0;
                    score = 0;
                    quizStarted = false;
                    quizCompleted = false;
                    answeredQuestions.clear();
                    selectedAnswers.clear();
                    isCorrect = null;
                  });
                },
                icon: const Icon(Icons.language),
                label: const Text('Choose Language'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}