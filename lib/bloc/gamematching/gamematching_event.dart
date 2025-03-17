import 'package:equatable/equatable.dart';

abstract class GameMatchingEvent extends Equatable {
  const GameMatchingEvent();

  @override
  List<Object> get props => [];
}

class SetTotalQuestionsEvent extends GameMatchingEvent {
  final int totalQuestions;

  const SetTotalQuestionsEvent(this.totalQuestions);

  @override
  List<Object> get props => [totalQuestions];
}

class AnswerSelectedEvent extends GameMatchingEvent {
  final String selectedAnswer;

  const AnswerSelectedEvent(this.selectedAnswer);

  @override
  List<Object> get props => [selectedAnswer];
}

class GenerateQuestionEvent extends GameMatchingEvent {}

class ResetQuizEvent extends GameMatchingEvent {}
