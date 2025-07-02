import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/latihanmenulis/latihanmenulis_bloc.dart';
import 'package:nyuumon/bloc/latihanmenulis/latihanmenulis_event.dart';
import 'package:nyuumon/bloc/latihanmenulis/latihanmenulis_state.dart';

class LatihanMenulisHirakataPage extends StatelessWidget {
  const LatihanMenulisHirakataPage({Key? key}) : super(key: key);

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
                  const SizedBox(width: 8),
                ],
              ),
            ),
            // Garis horizontal tipis berwarna abu-abu
            Container(
              height: 2, // Tinggi garis
              color: Colors.grey[300], // Warna abu-abu
            ),
            // Konten Halaman
            Padding(
              padding: const EdgeInsets.all(20),
              child: BlocConsumer<LatihanMenulisBloc, LatihanMenulisState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LatihanMenulisInitial) {
                    return _buildInitialInput(context);
                  } else if (state is QuestionGenerated) {
                    return _buildQuestion(context, state);
                  } else if (state is LatihanFinished) {
                    return _buildFinishedScreen(context, state);
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialInput(BuildContext context) {
    return Center(
      child: DropdownButton<int>(
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
                .read<LatihanMenulisBloc>()
                .add(SetTotalQuestionsEvent(value));
          }
        },
        hint: const Text("Pilih Jumlah Soal"),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, QuestionGenerated state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Timer: ${state.elapsedTime} s',
              style: const TextStyle(fontSize: 17)),
          const SizedBox(height: 15),
          Text('Soal ${state.questionIndex}/${state.totalQuestions}',
              style:
                  const TextStyle(fontSize: 25, fontStyle: FontStyle.italic)),
          const SizedBox(height: 25),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(state.currentCharacter,
                  style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          if (state.questionIndex < state.totalQuestions)
            ElevatedButton(
              onPressed: () {
                context
                    .read<LatihanMenulisBloc>()
                    .add(LatihanMenulisNextQuestion());
              },
              child: const Text("Next", style: TextStyle(fontSize: 20)),
            ),
          const SizedBox(height: 20),
          if (state.questionIndex == state.totalQuestions)
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
                  context.read<LatihanMenulisBloc>().add(SubmitLatihanEvent());
                });
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text("Selesai", style: TextStyle(fontSize: 20)),
            ),
          const SizedBox(height: 35),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Cobalah tulis pada buku anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishedScreen(BuildContext context, LatihanFinished state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Jumlah soal: ${state.totalQuestions}',
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
                context.read<LatihanMenulisBloc>().add(ResetLatihanEvent());
              });
            },
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            child:
                const Text("Restart Latihan", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
