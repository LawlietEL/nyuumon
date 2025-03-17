import 'package:equatable/equatable.dart';

abstract class LatihanMembacaEvent extends Equatable {
  const LatihanMembacaEvent();

  @override
  List<Object> get props => [];
}

class SetTotalQuestionsEvent extends LatihanMembacaEvent {
  final int totalQuestions;

  const SetTotalQuestionsEvent(this.totalQuestions);

  @override
  List<Object> get props => [totalQuestions];
}

class AnswerSelectedEvent extends LatihanMembacaEvent {
  final String selectedAnswer;

  const AnswerSelectedEvent(this.selectedAnswer);

  @override
  List<Object> get props => [selectedAnswer];
}

class GenerateQuestionEvent extends LatihanMembacaEvent {}

class ResetQuizEvent extends LatihanMembacaEvent {}
