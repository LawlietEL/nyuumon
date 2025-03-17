import 'package:equatable/equatable.dart';

abstract class GameMatchingState extends Equatable {
  const GameMatchingState();

  @override
  List<Object?> get props => [];
}

class GameMatchingInitial extends GameMatchingState {}

class QuestionGenerated extends GameMatchingState {
  final String currentQuestion;
  final List<String> answerOptions;
  final int questionIndex;
  final int? totalQuestions;
  final List<bool> answerResults;

  const QuestionGenerated({
    required this.currentQuestion,
    required this.answerOptions,
    required this.questionIndex,
    this.totalQuestions,
    required this.answerResults,
  });

  @override
  List<Object?> get props => [
        currentQuestion,
        answerOptions,
        questionIndex,
        totalQuestions,
        answerResults
      ];
}

class GameFinished extends GameMatchingState {
  final int correctAnswers;
  final int totalQuestions;

  const GameFinished(this.correctAnswers, this.totalQuestions);

  @override
  List<Object?> get props => [correctAnswers, totalQuestions];
}
