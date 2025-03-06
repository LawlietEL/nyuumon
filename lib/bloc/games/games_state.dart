// import 'package:equatable/equatable.dart';

// class GamesState extends Equatable {
//   final String currentQuestion;
//   final List<String> answerOptions;
//   final int questionIndex;
//   final int? totalQuestions;
//   final int correctAnswers;
//   final bool showResult;

//   const GamesState({
//     required this.currentQuestion,
//     required this.answerOptions,
//     required this.questionIndex,
//     this.totalQuestions,
//     this.correctAnswers = 0,
//     this.showResult = false,
//   });

//   GamesState copyWith({
//     String? currentQuestion,
//     List<String>? answerOptions,
//     int? questionIndex,
//     int? totalQuestions,
//     int? correctAnswers,
//     bool? showResult,
//   }) {
//     return GamesState(
//       currentQuestion: currentQuestion ?? this.currentQuestion,
//       answerOptions: answerOptions ?? this.answerOptions,
//       questionIndex: questionIndex ?? this.questionIndex,
//       totalQuestions: totalQuestions ?? this.totalQuestions,
//       correctAnswers: correctAnswers ?? this.correctAnswers,
//       showResult: showResult ?? this.showResult,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         currentQuestion,
//         answerOptions,
//         questionIndex,
//         totalQuestions,
//         correctAnswers,
//         showResult
//       ];
// }
