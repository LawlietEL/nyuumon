import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/gamematching/gamematching_bloc.dart';

// Halaman utama untuk permainan cocokkan Hiragana dan Katakana.
class GameMatchingPage extends StatefulWidget {
  const GameMatchingPage({super.key});

  @override
  _GameMatchingPageState createState() => _GameMatchingPageState();
}

class _GameMatchingPageState extends State<GameMatchingPage> {
  int?
      totalQuestions; // Variable untuk menyimpan total pertanyaan yang dipilih pengguna.

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
                    onPressed: () => Navigator.pop(
                        context), // Tombol kembali ke halaman sebelumnya.
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Matching HiraKata',
                          style: TextStyle(fontSize: 23)), // Judul halaman.
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
                    hint: const Text(
                        "Pilih Jumlah Soal"), // Dropdown untuk memilih jumlah soal.
                    items: [10, 20, 30, 40, 50].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        totalQuestions = newValue;
                      });
                      context.read<GameMatchingBloc>().add(SetTotalQuestionsEvent(
                          newValue!)); // Mengirim event untuk set total soal.
                    },
                  ),
                  if (totalQuestions !=
                      null) // Hanya membangun bagian ini jika totalQuestions telah di-set.
                    BlocBuilder<GameMatchingBloc, GameMatchingState>(
                      builder: (context, state) {
                        if (state is QuestionGenerated) {
                          return _buildQuestion(
                              context, state); // Membangun tampilan pertanyaan.
                        } else if (state is GameFinished) {
                          return _buildResult(context,
                              state); // Membangun tampilan hasil akhir game.
                        }
                        return const CircularProgressIndicator(); // Menampilkan loading jika state belum siap.
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, QuestionGenerated state) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
            'Soal ${state.questionIndex}/${state.totalQuestions ?? 0}', // Menampilkan nomor pertanyaan.
            style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic)),
        SizedBox(
          height: 25,
        ),
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
                  state.currentQuestion, // Menampilkan pertanyaan saat ini.
                  style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: state.answerOptions.map((option) {
              // Membangun pilihan jawaban.
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
                  onPressed: () => context
                      .read<GameMatchingBloc>()
                      .add(AnswerSelectedEvent(option)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildResult(BuildContext context, GameFinished state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
              'Total Point: ${state.correctAnswers} / ${state.totalQuestions}', // Menampilkan skor akhir.
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 60),
          ElevatedButton(
            onPressed: () => context
                .read<GameMatchingBloc>()
                .add(SetTotalQuestionsEvent(totalQuestions ?? 10)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text("Restart Quiz", style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
