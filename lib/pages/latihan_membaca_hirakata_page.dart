import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/latihanmembaca/latihanmembaca_bloc.dart';
import 'package:nyuumon/bloc/latihanmembaca/latihanmembaca_event.dart';
import 'package:nyuumon/bloc/latihanmembaca/latihanmembaca_state.dart';

class LatihanMembacaHirakataPage extends StatelessWidget {
  const LatihanMembacaHirakataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LatihanMembacaBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text('Membaca HiraKata',
                    style: TextStyle(fontSize: 23)),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              BlocBuilder<LatihanMembacaBloc, LatihanMembacaState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<int>(
                        value: state.totalQuestions,
                        hint: const Text("Pilih Jumlah Soal"),
                        onChanged: (newValue) => context
                            .read<LatihanMembacaBloc>()
                            .add(ChangeTotalQuestions(newValue)),
                        items: List.generate(10, (index) => 10 * (index + 1))
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                              value: value, child: Text('$value'));
                        }).toList(),
                      ),
                      Text(
                          'Soal ${state.questionIndex}/${state.totalQuestions ?? 0}',
                          style: TextStyle(
                              fontSize: 25, fontStyle: FontStyle.italic)),
                      if (state.totalQuestions != null) ...[
                        Text('${state.remainingTime}',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        _questionCard(state.currentQuestion),
                        _answerOptions(context, state),
                        _finishQuizButton(context, state),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionCard(String question) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
            color: Color.fromARGB(156, 239, 71, 107),
            border: Border.all(color: Colors.black)),
        child: Center(
            child: Text(question,
                style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
      ),
    );
  }

  Widget _answerOptions(BuildContext context, LatihanMembacaState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: state.answerOptions
          .map((option) => CircleAvatar(
                radius: 45,
                backgroundColor: Color.fromRGBO(81, 79, 80, 100),
                child: IconButton(
                  icon: Text(option,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () => context
                      .read<LatihanMembacaBloc>()
                      .add(AnswerSelected(option)),
                ),
              ))
          .toList(),
    );
  }

  Widget _finishQuizButton(BuildContext context, LatihanMembacaState state) {
    if (!state.isLastQuestionAnswered) return const SizedBox();
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Hasil Akhir'),
            content: Text(
                'Total Point: ${state.correctAnswers} / ${state.totalQuestions ?? 10}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<LatihanMembacaBloc>().add(ResetQuiz());
                },
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
      child: const Text('Selesai', style: TextStyle(fontSize: 22)),
    );
  }
}
