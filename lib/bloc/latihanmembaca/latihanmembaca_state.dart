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
  final int elapsedTime;

  QuestionGenerated({
    required this.currentQuestion,
    required this.answerOptions,
    required this.questionIndex,
    this.totalQuestions,
    required this.answerResults,
    required this.elapsedTime,
  });

  QuestionGenerated copyWith({
    String? currentQuestion,
    List<String>? answerOptions,
    int? questionIndex,
    int? totalQuestions,
    List<bool>? answerResults,
    int? elapsedTime,
  }) {
    return QuestionGenerated(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answerOptions: answerOptions ?? this.answerOptions,
      questionIndex: questionIndex ?? this.questionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      answerResults: answerResults ?? this.answerResults,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }

  @override
  List<Object?> get props => [
        currentQuestion,
        answerOptions,
        questionIndex,
        totalQuestions,
        answerResults,
        elapsedTime
      ];
}

class LatihanFinished extends LatihanMembacaState {
  final int correctAnswers;
  final int totalQuestions;
  final int elapsedTime;

  const LatihanFinished({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.elapsedTime,
  });

  @override
  List<Object?> get props => [correctAnswers, totalQuestions, elapsedTime];
}
