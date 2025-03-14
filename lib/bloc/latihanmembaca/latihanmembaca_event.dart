abstract class LatihanMembacaEvent {}

// Event untuk mengubah jumlah total pertanyaan.
class ChangeTotalQuestions extends LatihanMembacaEvent {
  final int? totalQuestions;

  ChangeTotalQuestions(this.totalQuestions);
}

// Event untuk menangani jawaban yang dipilih pengguna.
class AnswerSelected extends LatihanMembacaEvent {
  final String selectedAnswer;

  AnswerSelected(this.selectedAnswer);
}

// Event untuk mereset kuis ke kondisi awal.
class ResetQuiz extends LatihanMembacaEvent {}
