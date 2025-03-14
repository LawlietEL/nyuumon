import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'latihanmembaca_event.dart';
import 'latihanmembaca_state.dart';

class LatihanMembacaBloc
    extends Bloc<LatihanMembacaEvent, LatihanMembacaState> {
  final List<Map<String, String>> hirakataPairs = [
    {'hiragana': 'あ', 'katakana': 'ア'},
    {'hiragana': 'い', 'katakana': 'イ'},
    {'hiragana': 'う', 'katakana': 'ウ'},
    // Tambahkan pasangan hiragana-katakana lainnya...
  ];

  Timer? timer;
  Random random = Random();

  LatihanMembacaBloc() : super(LatihanMembacaState()) {
    on<ChangeTotalQuestions>((event, emit) {
      emit(state.copyWith(
          totalQuestions: event.totalQuestions, questionIndex: 1));
      _generateQuestion(emit);
    });

    on<AnswerSelected>((event, emit) {
      _checkAnswer(event.selectedAnswer, emit);
    });

    on<ResetQuiz>((event, emit) {
      timer?.cancel();
      emit(LatihanMembacaState());
    });
  }

  void _generateQuestion(Emitter<LatihanMembacaState> emit) {
    if (state.questionIndex > (state.totalQuestions ?? 10)) {
      return;
    }

    bool isHiraganaQuestion = random.nextBool();
    Map<String, String> pair =
        hirakataPairs[random.nextInt(hirakataPairs.length)];
    String questionChar = pair[isHiraganaQuestion ? 'hiragana' : 'katakana']!;
    String correctAnswer = pair[!isHiraganaQuestion ? 'hiragana' : 'katakana']!;

    List<String> answerOptions =
        _generateAnswerOptions(correctAnswer, isHiraganaQuestion);

    emit(state.copyWith(
      currentQuestion: questionChar,
      answerOptions: answerOptions,
      remainingTime: 10, // Reset waktu untuk pertanyaan baru
      isTimerStarted: false,
    ));

    if (!state.isTimerStarted) {
      _startTimer(emit);
    }
  }

  List<String> _generateAnswerOptions(
      String correctAnswer, bool isHiraganaQuestion) {
    List<String> answers = [correctAnswer];
    Set<String> options = Set.from(hirakataPairs
        .map((pair) => pair[isHiraganaQuestion ? 'katakana' : 'hiragana']!));

    while (answers.length < 4) {
      String randomAnswer = options.elementAt(random.nextInt(options.length));
      if (!answers.contains(randomAnswer)) {
        answers.add(randomAnswer);
      }
    }
    answers.shuffle();
    return answers;
  }

  void _checkAnswer(String selectedAnswer, Emitter<LatihanMembacaState> emit) {
    bool isCorrect = selectedAnswer ==
        state.answerOptions[
            0]; // Membandingkan dengan jawaban yang benar yang selalu di indeks 0 setelah shuffle

    emit(state.copyWith(
      correctAnswers:
          isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
      answerResults: List.from(state.answerResults)..add(isCorrect),
      questionIndex: state.questionIndex + 1,
      isLastQuestionAnswered:
          state.questionIndex >= (state.totalQuestions ?? 10),
    ));

    if (state.questionIndex >= (state.totalQuestions ?? 10)) {
      timer?.cancel(); // Stop timer jika kuis selesai
    } else {
      _generateQuestion(emit);
    }
  }

  void _startTimer(Emitter<LatihanMembacaState> emit) {
    emit(state.copyWith(isTimerStarted: true));

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.remainingTime == 0) {
        _generateQuestion(emit);
      } else {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
      }
    });
  }
}
