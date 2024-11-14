import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class LatihanMembacaHirakataPage extends StatefulWidget {
  const LatihanMembacaHirakataPage({super.key});

  @override
  _LatihanMembacaHirakataPageState createState() =>
      _LatihanMembacaHirakataPageState();
}

class _LatihanMembacaHirakataPageState
    extends State<LatihanMembacaHirakataPage> {
  final List<Map<String, String>> hirakataPairs = [
    {'hiragana': 'あ', 'katakana': 'ア'},
    {'hiragana': 'い', 'katakana': 'イ'},
    {'hiragana': 'う', 'katakana': 'ウ'},
    // Add other pairs here...
  ];

  String currentQuestion = '';
  List<String> answerOptions = [];
  int questionIndex = 1;
  int? totalQuestions;
  int correctAnswers = 0;
  List<bool> answerResults = [];
  Random random = Random();

  // Timer variables
  int remainingTime = 10; // 10 seconds countdown
  Timer? timer;
  bool isTimerStarted = false;

  // Track if the last answer has been selected
  bool isLastQuestionAnswered = false;

  @override
  void initState() {
    super.initState();
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
      questionChar =
          hirakataPairs[random.nextInt(hirakataPairs.length)]['hiragana']!;
      correctAnswer = hirakataPairs
          .firstWhere((pair) => pair['hiragana'] == questionChar)['katakana']!;
    } else {
      questionChar =
          hirakataPairs[random.nextInt(hirakataPairs.length)]['katakana']!;
      correctAnswer = hirakataPairs
          .firstWhere((pair) => pair['katakana'] == questionChar)['hiragana']!;
    }

    setState(() {
      currentQuestion = questionChar;
      answerOptions = _generateAnswerOptions(correctAnswer, isHiraganaQuestion);
      remainingTime = 10;
      isTimerStarted = false;
      isLastQuestionAnswered = false; // Reset last question flag
    });

    if (!isTimerStarted) {
      _startTimer();
    }
  }

  List<String> _generateAnswerOptions(
      String correctAnswer, bool isHiraganaQuestion) {
    List<String> answers = [correctAnswer];
    List<String> options = isHiraganaQuestion
        ? hirakataPairs.map((pair) => pair['katakana']!).toList()
        : hirakataPairs.map((pair) => pair['hiragana']!).toList();

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
    bool isCorrect = (hirakataPairs.any((pair) =>
            pair['hiragana'] == currentQuestion &&
            selectedAnswer == pair['katakana']) ||
        hirakataPairs.any((pair) =>
            pair['katakana'] == currentQuestion &&
            selectedAnswer == pair['hiragana']));
    answerResults.add(isCorrect);
    if (isCorrect) correctAnswers++;

    setState(() {
      questionIndex++;
      if (questionIndex > (totalQuestions ?? 10)) {
        isLastQuestionAnswered = true;
      } else {
        _generateQuestion();
      }
    });
  }

  void _startTimer() {
    setState(() {
      isTimerStarted = true;
    });

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime == 0) {
        _generateQuestion();
      } else {
        setState(() {
          remainingTime--;
        });
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      questionIndex = 1;
      correctAnswers = 0;
      answerResults.clear();
      totalQuestions = null;
      isTimerStarted = false;
      timer?.cancel();
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hasil Akhir'),
          content:
              Text('Total Point: $correctAnswers / ${totalQuestions ?? 10}'),
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
                        'Membaca HiraKata',
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
                    items: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
                        .map((int value) {
                      return DropdownMenuItem<int>(
                          value: value, child: Text('$value'));
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        totalQuestions = newValue!;
                        questionIndex = 0;
                        isTimerStarted = false;
                        _generateQuestion();
                      });
                    },
                  ),
                  Text(
                    'Soal $questionIndex/${totalQuestions ?? 0}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (totalQuestions != null) ...[
                    Text(
                      '$remainingTime',
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(),
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
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          currentQuestion,
                          style: const TextStyle(
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLastQuestionAnswered) ...[
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
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => _checkAnswer(option),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              if (isLastQuestionAnswered) ...[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      backgroundColor: Colors.blue, // Background color
                      side: BorderSide(color: Colors.grey), // Border color
                    ),
                    onPressed: () {
                      _showResultDialog();
                    },
                    child: const Text(
                      'Selesai',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ]
            ],
          ],
        ),
      ),
    );
  }
}
