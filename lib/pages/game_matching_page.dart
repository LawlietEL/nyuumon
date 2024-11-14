import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameMatchingPage extends StatefulWidget {
  const GameMatchingPage({super.key});

  @override
  _GameMatchingPageState createState() => _GameMatchingPageState();
}

class _GameMatchingPageState extends State<GameMatchingPage> {
  final List<String> hiragana = [
    'あ',
    'い',
    'う',
    'え',
    'お',
    'か',
    'き',
    'く',
    'け',
    'こ',
    'さ',
    'し',
    'す',
    'せ',
    'そ',
    'た',
    'ち',
    'つ',
    'て',
    'と',
    'な',
    'に',
    'ぬ',
    'ね',
    'の',
    'は',
    'ひ',
    'ふ',
    'へ',
    'ほ',
    'ま',
    'み',
    'む',
    'め',
    'も',
    'や',
    'ゆ',
    'よ',
    'ら',
    'り',
    'る',
    'れ',
    'ろ',
    'わ',
    'を',
    'ん',
  ];

  final List<String> katakana = [
    'ア',
    'イ',
    'ウ',
    'エ',
    'オ',
    'カ',
    'キ',
    'ク',
    'ケ',
    'コ',
    'サ',
    'シ',
    'ス',
    'セ',
    'ソ',
    'タ',
    'チ',
    'ツ',
    'テ',
    'ト',
    'ナ',
    'ニ',
    'ヌ',
    'ネ',
    'ノ',
    'ハ',
    'ヒ',
    'フ',
    'ヘ',
    'ホ',
    'マ',
    'ミ',
    'ム',
    'メ',
    'モ',
    'ヤ',
    'ユ',
    'ヨ',
    'ラ',
    'リ',
    'ル',
    'レ',
    'ロ',
    'ワ',
    'ヲ',
    'ン',
  ];

  String currentQuestion = '';
  List<String> answerOptions = [];
  int questionIndex = 1;
  int? totalQuestions;
  int correctAnswers = 0;
  List<bool> answerResults = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    if (questionIndex > (totalQuestions ?? 10)) {
      _showResultDialog();
      return;
    }

    bool isHiraganaQuestion = random.nextBool();
    String questionChar;
    String correctAnswer;

    if (isHiraganaQuestion) {
      questionChar = hiragana[random.nextInt(hiragana.length)];
      correctAnswer = katakana[hiragana.indexOf(questionChar)];
    } else {
      questionChar = katakana[random.nextInt(katakana.length)];
      correctAnswer = hiragana[katakana.indexOf(questionChar)];
    }

    setState(() {
      currentQuestion = questionChar;
      answerOptions = _generateAnswerOptions(correctAnswer, isHiraganaQuestion);
    });
  }

  List<String> _generateAnswerOptions(
      String correctAnswer, bool isHiraganaQuestion) {
    List<String> answers = [correctAnswer];
    List<String> options = isHiraganaQuestion ? katakana : hiragana;

    while (answers.length < 3) {
      String randomAnswer = options[random.nextInt(options.length)];
      if (!answers.contains(randomAnswer)) {
        answers.add(randomAnswer);
      }
    }
    answers.shuffle();
    return answers;
  }

  void _checkAnswer(String selectedAnswer) {
    bool isCorrect = (hiragana.contains(currentQuestion) &&
            selectedAnswer == katakana[hiragana.indexOf(currentQuestion)]) ||
        (katakana.contains(currentQuestion) &&
            selectedAnswer == hiragana[katakana.indexOf(currentQuestion)]);
    answerResults.add(isCorrect);
    if (isCorrect) correctAnswers++;

    if (questionIndex < (totalQuestions ?? 10)) {
      setState(() {
        questionIndex++;
        _generateQuestion();
      });
    } else {
      _showResultDialog();
    }
  }

  void _resetQuiz() {
    setState(() {
      questionIndex = 1;
      correctAnswers = 0;
      answerResults.clear();
      totalQuestions = null;
      _generateQuestion();
    });
  }

  void _showResultDialog() {
    _saveGameProgress();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hasil Akhir'),
          content:
              Text('Total Point: $correctAnswers / ${totalQuestions ?? 0}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveGameProgress() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print("No user logged in");
        return;
      }

      final gameProgressRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('matching_hirakata_game');

      await gameProgressRef.add({
        'score': correctAnswers,
        'totalQuestions': totalQuestions ?? 10,
        'answeredCorrectly': correctAnswers,
        'datePlayed': Timestamp.now(),
      });

      print("Game progress saved successfully!");
    } catch (e) {
      print("Error saving game progress: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 30, left: 5, bottom: 5, right: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Matching HiraKata',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<int>(
                    value: totalQuestions,
                    hint: const Text("Pilih Jumlah Soal"),
                    items: [10, 20, 30, 40, 50].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        totalQuestions = newValue!;
                        questionIndex = 1;
                        _generateQuestion();
                      });
                    },
                  ),
                  Text(
                    'Soal $questionIndex/${totalQuestions ?? 0}',
                    style: const TextStyle(
                        fontSize: 25, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (totalQuestions != null) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(156, 239, 71, 107),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          currentQuestion,
                          style: const TextStyle(
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: answerOptions.map((option) {
                    return CircleAvatar(
                      radius: 45,
                      backgroundColor: const Color.fromRGBO(81, 79, 80, 100),
                      child: IconButton(
                        icon: Text(
                          option,
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () => _checkAnswer(option),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
