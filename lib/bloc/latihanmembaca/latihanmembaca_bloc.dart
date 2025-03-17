import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'latihanmembaca_event.dart';
import 'latihanmembaca_state.dart';

class LatihanMembacaBloc
    extends Bloc<LatihanMembacaEvent, LatihanMembacaState> {
  final List<String> hiragana = [
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
    'ん'
  ];

  // Daftar karakter Katakana.
  final List<String> katakana = [
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
    'ン'
  ];

  Random random = Random();
  Timer? _timer;
  int _elapsedTime = 0;

  LatihanMembacaBloc() : super(LatihanMembacaInitial()) {
    on<SetTotalQuestionsEvent>(_onSetTotalQuestions);
    on<AnswerSelectedEvent>(_onAnswerSelected);
    on<GenerateQuestionEvent>(_onGenerateQuestion);
    on<ResetQuizEvent>(_onResetQuiz);
    on<UpdateTimeEvent>(_onUpdateTime);
  }

  void _onSetTotalQuestions(
      SetTotalQuestionsEvent event, Emitter<LatihanMembacaState> emit) {
    _startTimer();
    _elapsedTime = 0;
    emit(QuestionGenerated(
        currentQuestion: '',
        answerOptions: [],
        questionIndex: 1,
        totalQuestions: event.totalQuestions,
        answerResults: [],
        elapsedTime: _elapsedTime));
    add(GenerateQuestionEvent());
  }

  void _onAnswerSelected(
      AnswerSelectedEvent event, Emitter<LatihanMembacaState> emit) {
    final state = this.state as QuestionGenerated;
    int hiraganaIndex = hiragana.indexOf(state.currentQuestion);
    int katakanaIndex = katakana.indexOf(state.currentQuestion);
    bool isCorrect = (hiraganaIndex != -1 &&
            event.selectedAnswer == katakana[hiraganaIndex]) ||
        (katakanaIndex != -1 &&
            event.selectedAnswer == hiragana[katakanaIndex]);

    List<bool> updatedResults = List.from(state.answerResults)..add(isCorrect);
    if (state.questionIndex < (state.totalQuestions ?? 10)) {
      emit(state.copyWith(
          questionIndex: state.questionIndex + 1,
          answerResults: updatedResults));
      add(GenerateQuestionEvent());
    } else {
      _stopTimer();
      emit(LatihanFinished(
          correctAnswers: updatedResults.where((r) => r).length,
          totalQuestions: state.totalQuestions!,
          elapsedTime: _elapsedTime));
    }
  }

  void _onGenerateQuestion(
      GenerateQuestionEvent event, Emitter<LatihanMembacaState> emit) {
    final state = this.state as QuestionGenerated;
    if (state.questionIndex <= (state.totalQuestions ?? 10)) {
      bool isHiragana = random
          .nextBool(); // Secara acak memilih apakah menggunakan hiragana atau katakana
      List<String> sourceList =
          isHiragana ? hiragana : katakana; // Memilih sumber huruf
      List<String> targetList =
          isHiragana ? katakana : hiragana; // Memilih target huruf yang sesuai

      int index = random.nextInt(sourceList.length);
      String question = sourceList[index];
      String correctAnswer = targetList[index];

      List<String> allOptions = List.from(targetList)..shuffle(random);
      List<String> answerOptions =
          allOptions.where((option) => option != correctAnswer).take(2).toList()
            ..add(correctAnswer)
            ..shuffle(random);
      emit(state.copyWith(
          currentQuestion: question, answerOptions: answerOptions));
    }
  }

  void _onResetQuiz(ResetQuizEvent event, Emitter<LatihanMembacaState> emit) {
    _stopTimer();
    emit(LatihanMembacaInitial());
  }

  void _onUpdateTime(UpdateTimeEvent event, Emitter<LatihanMembacaState> emit) {
    _elapsedTime = event.elapsedTime;
    if (this.state is QuestionGenerated) {
      emit((this.state as QuestionGenerated)
          .copyWith(elapsedTime: _elapsedTime));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _elapsedTime++;
      add(UpdateTimeEvent(_elapsedTime));
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }
}
