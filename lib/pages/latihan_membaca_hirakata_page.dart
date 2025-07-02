import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/latihanmembaca/latihanmembaca_bloc.dart';
import 'package:nyuumon/bloc/latihanmembaca/latihanmembaca_event.dart';
import 'package:nyuumon/bloc/latihanmembaca/latihanmembaca_state.dart';

// Halaman utama untuk permainan cocokkan Hiragana dan Katakana.
class LatihanMembacaHirakataPage extends StatelessWidget {
  const LatihanMembacaHirakataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan tombol back dan judul
            Padding(
              padding: const EdgeInsets.only(
                  top: 30,
                  left: 5,
                  bottom: 5,
                  right: 10), // Padding di sekitar teks
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                      Future.delayed(const Duration(milliseconds: 250), () {
                        Navigator.pop(context); // tutup loading
                        Navigator.pop(context); // kembali
                      });
                    },
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
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
            // Garis horizontal tipis berwarna abu-abu
            Container(
              height: 2, // Tinggi garis
              color: Colors.grey[300], // Warna abu-abu
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<LatihanMembacaBloc, LatihanMembacaState>(
                builder: (context, state) {
                  if (state is QuestionGenerated) {
                    return Column(children: [
                      Text('Timer: ${state.elapsedTime} s',
                          style: TextStyle(fontSize: 17)),
                      SizedBox(height: 15),
                      _buildQuestion(context, state)
                    ]);
                  } else if (state is LatihanFinished) {
                    return _buildResult(context, state);
                  }
                  return _buildInitialInput(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialInput(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          items: const [
            10,
            15,
            20,
            25,
            30,
          ]
              .map((value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context
                  .read<LatihanMembacaBloc>()
                  .add(SetTotalQuestionsEvent(value));
            }
          },
          hint: const Text("Pilih Jumlah Soal"),
        ),
      ],
    );
  }

  Widget _buildQuestion(BuildContext context, QuestionGenerated state) {
    return Column(
      children: [
        Text('Soal ${state.questionIndex}/${state.totalQuestions ?? 0}',
            style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic)),
        SizedBox(height: 25),
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Center(
            child: Text(state.currentQuestion,
                style: const TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: state.answerOptions.map((option) {
              return CircleAvatar(
                radius: 45,
                backgroundColor: Colors.lightBlueAccent,
                child: IconButton(
                  icon: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => context
                      .read<LatihanMembacaBloc>()
                      .add(AnswerSelectedEvent(option)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildResult(BuildContext context, LatihanFinished state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Point: ${state.correctAnswers} / ${state.totalQuestions}',
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(height: 7),
          Text('Waktu: ${state.elapsedTime} detik',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 55),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
              Future.delayed(const Duration(milliseconds: 250), () {
                Navigator.pop(context);
                context.read<LatihanMembacaBloc>().add(ResetQuizEvent());
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child:
                const Text("Restart Latihan", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
