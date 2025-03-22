abstract class LatihanMenulisEvent {}

class SetTotalQuestionsEvent extends LatihanMenulisEvent {
  final int totalQuestions;

  SetTotalQuestionsEvent(this.totalQuestions);
}

class LatihanMenulisStart extends LatihanMenulisEvent {}

class LatihanMenulisNextQuestion extends LatihanMenulisEvent {}

class LatihanMenulisPreviousQuestion extends LatihanMenulisEvent {}

class SubmitLatihanEvent extends LatihanMenulisEvent {}

class ResetLatihanEvent extends LatihanMenulisEvent {}

class UpdateTimeEvent extends LatihanMenulisEvent {
  final int elapsedTime;

  UpdateTimeEvent(this.elapsedTime);
}
