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
    {'hiragana': 'え', 'katakana': 'エ'},
    {'hiragana': 'お', 'katakana': 'オ'},
    {'hiragana': 'か', 'katakana': 'カ'},
    {'hiragana': 'き', 'katakana': 'キ'},
    {'hiragana': 'く', 'katakana': 'ク'},
    {'hiragana': 'け', 'katakana': 'ケ'},
    {'hiragana': 'こ', 'katakana': 'コ'},
    {'hiragana': 'さ', 'katakana': 'サ'},
    {'hiragana': 'し', 'katakana': 'シ'},
    {'hiragana': 'す', 'katakana': 'ス'},
    {'hiragana': 'せ', 'katakana': 'セ'},
    {'hiragana': 'そ', 'katakana': 'ソ'},
    {'hiragana': 'た', 'katakana': 'タ'},
    {'hiragana': 'ち', 'katakana': 'チ'},
    {'hiragana': 'つ', 'katakana': 'ツ'},
    {'hiragana': 'て', 'katakana': 'テ'},
    {'hiragana': 'と', 'katakana': 'ト'},
    {'hiragana': 'な', 'katakana': 'ナ'},
    {'hiragana': 'に', 'katakana': 'ニ'},
    {'hiragana': 'ぬ', 'katakana': 'ヌ'},
    {'hiragana': 'ね', 'katakana': 'ネ'},
    {'hiragana': 'の', 'katakana': 'ノ'},
    {'hiragana': 'は', 'katakana': 'ハ'},
    {'hiragana': 'ひ', 'katakana': 'ヒ'},
    {'hiragana': 'ふ', 'katakana': 'フ'},
    {'hiragana': 'へ', 'katakana': 'ヘ'},
    {'hiragana': 'ほ', 'katakana': 'ホ'},
    {'hiragana': 'ま', 'katakana': 'マ'},
    {'hiragana': 'み', 'katakana': 'ミ'},
    {'hiragana': 'む', 'katakana': 'ム'},
    {'hiragana': 'め', 'katakana': 'メ'},
    {'hiragana': 'も', 'katakana': 'モ'},
    {'hiragana': 'や', 'katakana': 'ヤ'},
    {'hiragana': 'ゆ', 'katakana': 'ユ'},
    {'hiragana': 'よ', 'katakana': 'ヨ'},
    {'hiragana': 'ら', 'katakana': 'ラ'},
    {'hiragana': 'り', 'katakana': 'リ'},
    {'hiragana': 'る', 'katakana': 'ル'},
    {'hiragana': 'れ', 'katakana': 'レ'},
    {'hiragana': 'ろ', 'katakana': 'ロ'},
    {'hiragana': 'わ', 'katakana': 'ワ'},
    {'hiragana': 'を', 'katakana': 'ヲ'},
    {'hiragana': 'ん', 'katakana': 'ン'},
  ];

  late List<Map<String, String>> soalList;
  int currentIndex = 0;
  late bool isHiraganaToKatakana;
  int timer = 15;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    soalList = generateSoal();
    isHiraganaToKatakana = Random().nextBool();
    startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  List<Map<String, String>> generateSoal() {
    final random = Random();
    final selectedHiragana = <Map<String, String>>[];
    final hiraganaSet = Set<int>();

    while (hiraganaSet.length < 15) {
      final index = random.nextInt(hirakataPairs.length);
      if (!hiraganaSet.contains(index)) {
        hiraganaSet.add(index);
        selectedHiragana.add(hirakataPairs[index]);
      }
    }
    return selectedHiragana;
  }

  List<String> generateChoices(String correctAnswer) {
    final random = Random();
    final choices = <String>[correctAnswer];
    final usedIndices = <int>[];

    while (choices.length < 3) {
      final index = random.nextInt(hirakataPairs.length);
      final wrongAnswer = isHiraganaToKatakana
          ? hirakataPairs[index]['katakana']!
          : hirakataPairs[index]['hiragana']!;
      if (!usedIndices.contains(index) && wrongAnswer != correctAnswer) {
        usedIndices.add(index);
        choices.add(wrongAnswer);
      }
    }

    choices.shuffle();
    return choices;
  }

  void startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--;
        } else {
          navigateToNext();
        }
      });
    });
  }

  void resetTimer() {
    _countdownTimer?.cancel();
    timer = 15;
    startTimer();
  }

  void navigateToPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        isHiraganaToKatakana = Random().nextBool();
        resetTimer();
      });
    }
  }

  void navigateToNext() {
    if (currentIndex < soalList.length - 1) {
      setState(() {
        currentIndex++;
        isHiraganaToKatakana = Random().nextBool();
        resetTimer();
      });
    } else {
      _countdownTimer?.cancel(); // Berhenti jika sudah di soal terakhir
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSoal = soalList[currentIndex];
    final question = isHiraganaToKatakana
        ? currentSoal['hiragana']!
        : currentSoal['katakana']!;
    final correctAnswer = isHiraganaToKatakana
        ? currentSoal['katakana']!
        : currentSoal['hiragana']!;
    final choices = generateChoices(correctAnswer);

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
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Membaca HiraKata',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Waktu: $timer detik',
                    style: const TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Soal ${currentIndex + 1}/15',
                style: const TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_left,
                      size: 40,
                    ),
                    onPressed: navigateToPrevious,
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 239, 71, 107),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        question,
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right,
                      size: 40,
                    ),
                    onPressed: navigateToNext,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: choices.map((choice) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: const Color.fromRGBO(81, 79, 80, 100),
                    child: TextButton(
                      onPressed: () {
                        if (choice == correctAnswer) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Benar!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          navigateToNext();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Salah, coba lagi!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: Text(
                        choice,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (currentIndex == soalList.length - 1) ...[
              const SizedBox(height: 20),
              Container(
                width: 150,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: const Color.fromARGB(255, 44, 36, 36),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    // Logic for submitting, could navigate to another page or show a summary.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Soal selesai!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
