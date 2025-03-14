class LatihanMembacaState {
  final String currentQuestion;
  final List<String> answerOptions;
  final int questionIndex;
  final int? totalQuestions;
  final int correctAnswers;
  final List<bool> answerResults;
  final int remainingTime;
  final bool isTimerStarted;
  final bool isLastQuestionAnswered;

  LatihanMembacaState({
    this.currentQuestion = '',
    this.answerOptions = const [],
    this.questionIndex = 1,
    this.totalQuestions,
    this.correctAnswers = 0,
    this.answerResults = const [],
    this.remainingTime = 10,
    this.isTimerStarted = false,
    this.isLastQuestionAnswered = false,
  });

  LatihanMembacaState copyWith({
    String? currentQuestion,
    List<String>? answerOptions,
    int? questionIndex,
    int? totalQuestions,
    int? correctAnswers,
    List<bool>? answerResults,
    int? remainingTime,
    bool? isTimerStarted,
    bool? isLastQuestionAnswered,
  }) {
    return LatihanMembacaState(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answerOptions: answerOptions ?? this.answerOptions,
      questionIndex: questionIndex ?? this.questionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      answerResults: answerResults ?? this.answerResults,
      remainingTime: remainingTime ?? this.remainingTime,
      isTimerStarted: isTimerStarted ?? this.isTimerStarted,
      isLastQuestionAnswered:
          isLastQuestionAnswered ?? this.isLastQuestionAnswered,
    );
  }
}
