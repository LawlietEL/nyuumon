import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class LatihanMenulisHirakataPage extends StatefulWidget {
  const LatihanMenulisHirakataPage({super.key});

  @override
  _LatihanMenulisHirakataPageState createState() =>
      _LatihanMenulisHirakataPageState();
}

class _LatihanMenulisHirakataPageState
    extends State<LatihanMenulisHirakataPage> {
  int _currentQuestionIndex = 0;
  int _timerValue = 10;
  late Timer _timer;
  late String _currentCharacter;

  final List<String> _hiraganaKatakanaList = [
    // Hiragana
    'あ', 'い', 'う', 'え', 'お',
    'か', 'き', 'く', 'け', 'こ',
    'さ', 'し', 'す', 'せ', 'そ',
    'た', 'ち', 'つ', 'て', 'と',
    'な', 'に', 'ぬ', 'ね', 'の',
    'は', 'ひ', 'ふ', 'へ', 'ほ',
    'ま', 'み', 'む', 'め', 'も',
    'や', 'ゆ', 'よ',
    'ら', 'り', 'る', 'れ', 'ろ',
    'わ', 'を',
    'ん',

    // Katakana
    'ア', 'イ', 'ウ', 'エ', 'オ',
    'カ', 'キ', 'ク', 'ケ', 'コ',
    'サ', 'シ', 'ス', 'セ', 'ソ',
    'タ', 'チ', 'ツ', 'テ', 'ト',
    'ナ', 'ニ', 'ヌ', 'ネ', 'ノ',
    'ハ', 'ヒ', 'フ', 'ヘ', 'ホ',
    'マ', 'ミ', 'ム', 'メ', 'モ',
    'ヤ', 'ユ', 'ヨ',
    'ラ', 'リ', 'ル', 'レ', 'ロ',
    'ワ', 'ヲ',
    'ン'
  ];

  @override
  void initState() {
    super.initState();
    _currentCharacter = _getRandomHiraganaKatakana();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerValue > 0) {
          _timerValue--;
        } else {
          _resetTimer();
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _timerValue = 10;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < 14) {
      setState(() {
        _currentQuestionIndex++;
        _currentCharacter = _getRandomHiraganaKatakana(); // Perbarui soal
        _resetTimer();
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _currentCharacter = _getRandomHiraganaKatakana(); // Perbarui soal
        _resetTimer();
      });
    }
  }

  String _getRandomHiraganaKatakana() {
    final random = Random();
    return _hiraganaKatakanaList[random.nextInt(_hiraganaKatakanaList.length)];
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Menulis HiraKata',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),

            // Timer dengan tulisan "Waktu 10 Detik"
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    'Waktu $_timerValue Detik',
                    style: const TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Tulisan Soal "x/15"
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Soal ${_currentQuestionIndex + 1}/15',
                style: const TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Row untuk tombol panah kiri, kotak huruf, dan panah kanan
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
                    onPressed: _previousQuestion,
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 239, 71, 107),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        _currentCharacter,
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
                    onPressed: _nextQuestion,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // Kotak untuk tempat menulis
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Latihan Menulis',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tempat untuk\nmenulis tangan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
