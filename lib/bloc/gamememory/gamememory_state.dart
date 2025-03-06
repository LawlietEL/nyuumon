// State class containing the game state.
class GameMemoryState {
  final List<String> cards;
  final List<bool> cardVisibility;
  final int pairsFound;
  final int moves;
  final int numberOfPairs;
  final bool gameStarted;
  final Stopwatch timer;

  GameMemoryState({
    required this.cards,
    required this.cardVisibility,
    required this.pairsFound,
    required this.moves,
    required this.numberOfPairs,
    required this.gameStarted,
    required this.timer,
  });

  // Ensure all nullable values have defaults
  GameMemoryState copyWith({
    List<String>? cards,
    List<bool>? cardVisibility,
    int? pairsFound,
    int? moves,
    int? numberOfPairs,
    bool? gameStarted,
    Stopwatch? timer,
  }) {
    return GameMemoryState(
      cards: cards ?? this.cards,
      cardVisibility:
          cardVisibility ?? List.generate(this.cards.length, (_) => false),
      pairsFound: pairsFound ?? this.pairsFound,
      moves: moves ?? this.moves,
      numberOfPairs: numberOfPairs ?? this.numberOfPairs,
      gameStarted: gameStarted ?? this.gameStarted,
      timer: timer ?? this.timer,
    );
  }
}
