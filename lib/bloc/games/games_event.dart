import 'package:equatable/equatable.dart';

abstract class GamesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectTotalQuestionsEvent extends GamesEvent {
  final int totalQuestions;

  SelectTotalQuestionsEvent(this.totalQuestions);

  @override
  List<Object?> get props => [totalQuestions];
}

class CheckAnswerEvent extends GamesEvent {
  final String selectedAnswer;

  CheckAnswerEvent(this.selectedAnswer);

  @override
  List<Object?> get props => [selectedAnswer];
}

class ResetGameEvent extends GamesEvent {}  // Event untuk reset game
