// Define abstract base class for all events.
abstract class GameMemoryEvent {}

// Event to increment the counter.
class IncrementCounterEvent extends GameMemoryEvent {}

// Event to start the game with a selected number of pairs.
class StartGameEvent extends GameMemoryEvent {
  final int numberOfPairs;

  StartGameEvent({required this.numberOfPairs});
}

// Event to handle card taps.
class CardTappedEvent extends GameMemoryEvent {
  final int cardIndex;

  CardTappedEvent({required this.cardIndex});
}
