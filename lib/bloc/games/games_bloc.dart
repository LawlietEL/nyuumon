import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/games/games_event.dart';
import 'package:nyuumon/bloc/games/games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final List<String> hiragana;
  final List<String> katakana;
  final Random random = Random();

  GamesBloc(this.hiragana, this.katakana)
      : super(GamesState(
          currentQuestion: '',
          answerOptions: [],
          questionIndex: 1,
        )) {
    on<SelectTotalQuestionsEvent>(_onSelectTotalQuestions);
    on<CheckAnswerEvent>(_onCheckAnswer);
    on<ResetGameEvent>(_onResetGame); // Event handler untuk reset game
  }

  void _onSelectTotalQuestions(
      SelectTotalQuestionsEvent event, Emitter<GamesState> emit) {
    emit(state.copyWith(
        totalQuestions: event.totalQuestions,
        questionIndex: 1,
        correctAnswers: 0));
    _generateQuestion(emit);
  }

  void _generateQuestion(Emitter<GamesState> emit) {
    if (state.questionIndex > (state.totalQuestions ?? 10)) {
      emit(state.copyWith(showResult: true));
      return;
    }

    bool isHiraganaQuestion = random.nextBool();
    String questionChar;
    String correctAnswer;

    if (isHiraganaQuestion) {
      questionChar = hiragana[random.nextInt(hiragana.length)];
      correctAnswer = katakana[hiragana.indexOf(questionChar)];
    } else {
      questionChar = katakana[random.nextInt(katakana.length)];
      correctAnswer = hiragana[katakana.indexOf(questionChar)];
    }

    List<String> answers = [correctAnswer];
    List<String> options = isHiraganaQuestion ? katakana : hiragana;
    while (answers.length < 3) {
      String randomAnswer = options[random.nextInt(options.length)];
      if (!answers.contains(randomAnswer)) {
        answers.add(randomAnswer);
      }
    }
    answers.shuffle();

    emit(state.copyWith(currentQuestion: questionChar, answerOptions: answers));
  }

  void _onCheckAnswer(CheckAnswerEvent event, Emitter<GamesState> emit) {
    bool isCorrect = (hiragana.contains(state.currentQuestion) &&
            event.selectedAnswer ==
                katakana[hiragana.indexOf(state.currentQuestion)]) ||
        (katakana.contains(state.currentQuestion) &&
            event.selectedAnswer ==
                hiragana[katakana.indexOf(state.currentQuestion)]);

    int newCorrectAnswers = state.correctAnswers + (isCorrect ? 1 : 0);

    if (state.questionIndex < (state.totalQuestions ?? 10)) {
      // Jika bukan soal terakhir, lanjutkan ke soal berikutnya
      emit(state.copyWith(
        questionIndex: state.questionIndex + 1,
        correctAnswers: newCorrectAnswers,
      ));
      _generateQuestion(emit);
    } else {
      // Jika sudah soal terakhir, tampilkan hasil akhir
      emit(state.copyWith(correctAnswers: newCorrectAnswers, showResult: true));
    }
  }

  // Event handler untuk reset game
  void _onResetGame(ResetGameEvent event, Emitter<GamesState> emit) {
    emit(state.copyWith(
      currentQuestion: '',
      answerOptions: [],
      questionIndex: 1,
      correctAnswers: 0,
      showResult: false,
      totalQuestions: null, // Reset jumlah soal
    ));
  }
}
