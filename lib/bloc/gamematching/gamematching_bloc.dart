import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'gamematching_event.dart';
import 'gamematching_state.dart';

class GameMatchingBloc extends Bloc<GameMatchingEvent, GameMatchingState> {
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

  int questionIndex = 1;
  int correctAnswers = 0;
  List<bool> answerResults = [];
  Random random = Random();
  int? totalQuestions;

  GameMatchingBloc() : super(GameMatchingInitial()) {
    on<GenerateQuestionEvent>(_onGenerateQuestion);
    on<AnswerSelectedEvent>(_onAnswerSelected);
    on<SetTotalQuestionsEvent>(_onSetTotalQuestions);
    on<ResetQuizEvent>(_onResetQuiz);
  }

  void _onResetQuiz(ResetQuizEvent event, Emitter<GameMatchingState> emit) {
    emit(GameMatchingInitial());
  }

  void _onSetTotalQuestions(
      SetTotalQuestionsEvent event, Emitter<GameMatchingState> emit) {
    totalQuestions = event.totalQuestions;
    questionIndex = 1;
    correctAnswers = 0;
    answerResults.clear();
    add(GenerateQuestionEvent());
  }

  void _onAnswerSelected(
      AnswerSelectedEvent event, Emitter<GameMatchingState> emit) {
    if (state is QuestionGenerated) {
      String currentQuestion = (state as QuestionGenerated).currentQuestion;
      int hiraganaIndex = hiragana.indexOf(currentQuestion);
      int katakanaIndex = katakana.indexOf(currentQuestion);

      bool isCorrect = (hiraganaIndex != -1 &&
              event.selectedAnswer == katakana[hiraganaIndex]) ||
          (katakanaIndex != -1 &&
              event.selectedAnswer == hiragana[katakanaIndex]);

      answerResults.add(isCorrect);
      if (isCorrect) {
        correctAnswers++;
      }
      questionIndex++;
      if (questionIndex <= (totalQuestions ?? 10)) {
        add(GenerateQuestionEvent());
      } else {
        emit(GameFinished(correctAnswers, totalQuestions ?? 10));
      }
    }
  }

  void _onGenerateQuestion(
      GenerateQuestionEvent event, Emitter<GameMatchingState> emit) {
    if (questionIndex > (totalQuestions ?? 10)) {
      emit(GameFinished(correctAnswers, totalQuestions ?? 10));
      return;
    }

    bool isHiraganaQuestion = random.nextBool();
    String questionChar = isHiraganaQuestion
        ? hiragana[random.nextInt(hiragana.length)]
        : katakana[random.nextInt(katakana.length)];
    int index = isHiraganaQuestion
        ? hiragana.indexOf(questionChar)
        : katakana.indexOf(questionChar);
    String correctAnswer =
        isHiraganaQuestion ? katakana[index] : hiragana[index];

    List<String> answers =
        _generateAnswerOptions(correctAnswer, isHiraganaQuestion);

    emit(QuestionGenerated(
        currentQuestion: questionChar,
        answerOptions: answers,
        questionIndex: questionIndex,
        totalQuestions: totalQuestions,
        answerResults: answerResults));
  }

  List<String> _generateAnswerOptions(
      String correctAnswer, bool isHiraganaQuestion) {
    List<String> answers = [correctAnswer];
    List<String> options = isHiraganaQuestion ? katakana : hiragana;

    while (answers.length < 3) {
      // Mengatur jumlah pilihan jawaban menjadi tiga.
      String randomAnswer = options[random.nextInt(options.length)];
      if (!answers.contains(randomAnswer)) {
        answers.add(randomAnswer);
      }
    }
    answers.shuffle(random);
    return answers;
  }
}
