import 'package:equatable/equatable.dart';

abstract class LatihanMembacaState extends Equatable {
  const LatihanMembacaState();

  @override
  List<Object?> get props => [];
}

class LatihanMembacaInitial extends LatihanMembacaState {}

class QuestionGenerated extends LatihanMembacaState {
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

class LatihanFinished extends LatihanMembacaState {
  final int correctAnswers;
  final int totalQuestions;

  const LatihanFinished(this.correctAnswers, this.totalQuestions);

  @override
  List<Object?> get props => [correctAnswers, totalQuestions];
}
