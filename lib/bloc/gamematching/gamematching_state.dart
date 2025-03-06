part of 'gamematching_bloc.dart';

// Base class for all game matching states
abstract class GameMatchingState extends Equatable {
  const GameMatchingState();

  @override
  List<Object?> get props => [];
}

// State when the game is initially loaded or reset
class GameMatchingInitial extends GameMatchingState {}

// State when a new question is generated
class QuestionGenerated extends GameMatchingState {
  final String currentQuestion;
  final List<String> answerOptions;
  final int questionIndex;
  final int? totalQuestions; // Nullable to represent that it may not be set
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

// State when the game has finished
class GameFinished extends GameMatchingState {
  final int correctAnswers;
  final int
      totalQuestions; // Non-nullable as this state represents end of the game

  const GameFinished(this.correctAnswers, this.totalQuestions);

  @override
  List<Object?> get props => [correctAnswers, totalQuestions];
}
