import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyuumon/bloc/latihanmenulis/latihanmenulis_event.dart';
import 'package:nyuumon/bloc/latihanmenulis/latihanmenulis_state.dart';

class LatihanMenulisBloc
    extends Bloc<LatihanMenulisEvent, LatihanMenulisState> {
  Timer? _timer;
  int _elapsedTime = 0;

  LatihanMenulisBloc() : super(LatihanMenulisInitial()) {
    on<SetTotalQuestionsEvent>(_onSetTotalQuestions);
    on<LatihanMenulisStart>((event, emit) => _onStart(emit));
    on<LatihanMenulisNextQuestion>((event, emit) => _onNextQuestion(emit));
    on<LatihanMenulisPreviousQuestion>(
        (event, emit) => _onPreviousQuestion(emit));
    on<ResetLatihanEvent>((event, emit) => emit(LatihanMenulisInitial()));
    on<UpdateTimeEvent>(_onUpdateTime);
    on<SubmitLatihanEvent>(_onSubmitLatihan); // Handle SubmitLatihanEvent
  }

  void _onSetTotalQuestions(
      SetTotalQuestionsEvent event, Emitter<LatihanMenulisState> emit) {
    _startTimer();
    _elapsedTime = 0;
    emit(QuestionGenerated(
        currentCharacter: '',
        questionIndex: 1,
        totalQuestions: event.totalQuestions,
        elapsedTime: _elapsedTime));
    add(LatihanMenulisStart());
  }

  void _onStart(Emitter<LatihanMenulisState> emit) {
    final currentState = state;
    if (currentState is QuestionGenerated) {
      String newCharacter = _getRandomHiraganaKatakana();
      emit(currentState.copyWith(
        currentCharacter: newCharacter,
        questionHistory: List.from(currentState.questionHistory)
          ..add(newCharacter),
      ));
    }
  }

  void _onNextQuestion(Emitter<LatihanMenulisState> emit) {
    final currentState = state as QuestionGenerated;
    if (currentState.questionIndex < currentState.totalQuestions) {
      final newIndex = currentState.questionIndex + 1;
      final newCharacter = _getRandomHiraganaKatakana();
      emit(currentState.copyWith(
        questionIndex: newIndex,
        currentCharacter: newCharacter,
        questionHistory: List.from(currentState.questionHistory)
          ..add(newCharacter),
      ));
    } else {
      _timer?.cancel();
      emit(LatihanFinished(
          totalQuestions: currentState.totalQuestions,
          elapsedTime: _elapsedTime));
    }
  }

  void _onPreviousQuestion(Emitter<LatihanMenulisState> emit) {
    final currentState = state as QuestionGenerated;
    if (currentState.questionIndex > 1) {
      final newIndex = currentState.questionIndex - 1;
      emit(currentState.copyWith(
        questionIndex: newIndex,
        currentCharacter: currentState.questionHistory[newIndex - 1],
      ));
    }
  }

  void _onUpdateTime(UpdateTimeEvent event, Emitter<LatihanMenulisState> emit) {
    _elapsedTime = event.elapsedTime;
    if (state is QuestionGenerated) {
      emit((state as QuestionGenerated).copyWith(elapsedTime: _elapsedTime));
    }
  }

  void _onSubmitLatihan(
      SubmitLatihanEvent event, Emitter<LatihanMenulisState> emit) {
    final currentState = state as QuestionGenerated;
    emit(LatihanFinished(
        totalQuestions: currentState.totalQuestions,
        elapsedTime: currentState.elapsedTime));
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      add(UpdateTimeEvent(_elapsedTime + 1));
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String _getRandomHiraganaKatakana() {
    final random = Random();
    const List<String> hiraganaKatakanaList = [
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
    return hiraganaKatakanaList[random.nextInt(hiraganaKatakanaList.length)];
  }
}
