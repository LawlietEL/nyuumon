import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/games/games_bloc.dart';
import 'package:nyuumon/bloc/games/games_event.dart';
import 'package:nyuumon/bloc/games/games_state.dart';

class GameMatchingPage extends StatelessWidget {
  const GameMatchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hiragana = [
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
    final katakana = [
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

    return BlocProvider(
      create: (_) => GamesBloc(hiragana, katakana),
      child: Scaffold(
        body: BlocBuilder<GamesBloc, GamesState>(
          builder: (context, state) {
            if (state.showResult &&
                state.questionIndex == state.totalQuestions) {
              // Menampilkan hasil akhir di pop-up hanya jika sudah selesai (soal terakhir)
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Hasil Akhir'),
                    content: Text(
                        'Total Point: ${state.correctAnswers} / ${state.totalQuestions}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Menutup pop-up dan mengirimkan event untuk mereset permainan
                          Navigator.pop(context);
                          context.read<GamesBloc>().add(ResetGameEvent());
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                );
              });
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 5, bottom: 5, right: 10),
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
                    child: DropdownButton<int>(
                      value: state.totalQuestions,
                      hint: const Text("Pilih Jumlah Soal"),
                      items: [10, 20, 30, 40, 50].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          // Reset hasil game sebelumnya sebelum memulai game baru
                          context.read<GamesBloc>().add(ResetGameEvent());
                          context.read<GamesBloc>().add(
                              SelectTotalQuestionsEvent(
                                  value)); // Memilih jumlah soal
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Soal ${state.questionIndex}/${state.totalQuestions ?? 0}',
                    style: const TextStyle(
                        fontSize: 25, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(156, 239, 71, 107),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          state.currentQuestion,
                          style: const TextStyle(
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: state.answerOptions.map((option) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundColor:
                              const Color.fromRGBO(81, 79, 80, 100),
                          child: IconButton(
                            icon: Text(
                              option,
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: () => context
                                .read<GamesBloc>()
                                .add(CheckAnswerEvent(option)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
