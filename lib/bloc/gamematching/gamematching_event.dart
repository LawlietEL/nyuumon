part of 'gamematching_bloc.dart';

// Base class for all GameMatching events
abstract class GameMatchingEvent extends Equatable {
  const GameMatchingEvent();

  @override
  List<Object> get props => [];
}

// Event to generate a new question
class GenerateQuestionEvent extends GameMatchingEvent {}

// Event triggered when an answer is selected by the user
class AnswerSelectedEvent extends GameMatchingEvent {
  final String selectedAnswer;

  const AnswerSelectedEvent(this.selectedAnswer);

  @override
  List<Object> get props => [selectedAnswer];
}

// Event to set the total number of questions for the game
class SetTotalQuestionsEvent extends GameMatchingEvent {
  final int totalQuestions;

  const SetTotalQuestionsEvent(this.totalQuestions);

  @override
  List<Object> get props => [totalQuestions];
}
