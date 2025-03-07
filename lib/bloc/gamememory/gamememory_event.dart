// Abstract class untuk semua event game memory
abstract class GameMemoryEvent {}

// Event untuk memulai game dengan jumlah soal yang dipilih
class StartGameEvent extends GameMemoryEvent {
  final int numberOfPairs;

  StartGameEvent({required this.numberOfPairs});
}

// Event ketika user mengklik kartu
class CardTappedEvent extends GameMemoryEvent {
  final int cardIndex;

  CardTappedEvent({required this.cardIndex});
}

// Event untuk memperbarui waktu yang berjalan
class UpdateTimerEvent extends GameMemoryEvent {}

// Event untuk mereset game ke kondisi awal
class ResetGameEvent extends GameMemoryEvent {}
