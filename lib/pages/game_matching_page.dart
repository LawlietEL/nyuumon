import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/gamematching/gamematching_bloc.dart';
import 'package:nyuumon/bloc/gamematching/gamematching_event.dart';
import 'package:nyuumon/bloc/gamematching/gamematching_state.dart';

// Halaman utama untuk permainan cocokkan Hiragana dan Katakana.
class GameMatchingPage extends StatelessWidget {
  const GameMatchingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
            child: const Text('Matching HiraKata',
                style: TextStyle(fontSize: 23))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(color: Colors.grey, thickness: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<GameMatchingBloc, GameMatchingState>(
                builder: (context, state) {
                  if (state is QuestionGenerated) {
                    return _buildQuestion(context, state);
                  } else if (state is GameFinished) {
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
          items: const [10, 20, 30, 40, 50]
              .map((value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context
                  .read<GameMatchingBloc>()
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
            color: Color.fromARGB(156, 239, 71, 107),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Center(
            child: Text(state.currentQuestion,
                style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
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
          Text('Total Point: ${state.correctAnswers} / ${state.totalQuestions}',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              context.read<GameMatchingBloc>().add(ResetQuizEvent());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text("Restart Game", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
