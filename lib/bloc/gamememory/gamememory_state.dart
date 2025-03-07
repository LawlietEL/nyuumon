// State untuk menyimpan kondisi permainan
class GameMemoryState {
  final List<String> cards;
  final List<bool> cardVisibility;
  final int pairsFound;
  final int moves;
  final int numberOfPairs;
  final bool gameStarted;
  final bool gameFinished;
  final int elapsedTime; // Menyimpan waktu berjalan dalam detik

  GameMemoryState({
    required this.cards,
    required this.cardVisibility,
    required this.pairsFound,
    required this.moves,
    required this.numberOfPairs,
    required this.gameStarted,
    required this.gameFinished,
    required this.elapsedTime,
  });

  // Method untuk membuat state baru dengan perubahan tertentu
  GameMemoryState copyWith({
    List<String>? cards,
    List<bool>? cardVisibility,
    int? pairsFound,
    int? moves,
    int? numberOfPairs,
    bool? gameStarted,
    bool? gameFinished,
    int? elapsedTime,
  }) {
    return GameMemoryState(
      cards: cards ?? this.cards,
      cardVisibility: cardVisibility ?? this.cardVisibility,
      pairsFound: pairsFound ?? this.pairsFound,
      moves: moves ?? this.moves,
      numberOfPairs: numberOfPairs ?? this.numberOfPairs,
      gameStarted: gameStarted ?? this.gameStarted,
      gameFinished: gameFinished ?? this.gameFinished,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}
