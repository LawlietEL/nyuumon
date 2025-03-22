abstract class LatihanMenulisState {}

class LatihanMenulisInitial extends LatihanMenulisState {}

class QuestionGenerated extends LatihanMenulisState {
  final String currentCharacter;
  final int questionIndex;
  final int totalQuestions;
  final List<String> questionHistory;
  final int elapsedTime;

  QuestionGenerated({
    required this.currentCharacter,
    required this.questionIndex,
    required this.totalQuestions,
    this.questionHistory = const [],
    required this.elapsedTime,
  });

  QuestionGenerated copyWith({
    String? currentCharacter,
    int? questionIndex,
    int? totalQuestions,
    List<String>? questionHistory,
    int? elapsedTime,
  }) {
    return QuestionGenerated(
      currentCharacter: currentCharacter ?? this.currentCharacter,
      questionIndex: questionIndex ?? this.questionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questionHistory: questionHistory ?? this.questionHistory,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

class LatihanFinished extends LatihanMenulisState {
  final int totalQuestions;
  final int elapsedTime;

  LatihanFinished({
    required this.totalQuestions,
    required this.elapsedTime,
  });
}
