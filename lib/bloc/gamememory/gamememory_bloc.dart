import 'package:flutter_bloc/flutter_bloc.dart';
import 'gamememory_event.dart';
import 'gamememory_state.dart';

class GameMemoryBloc extends Bloc<GameMemoryEvent, GameMemoryState> {
  GameMemoryBloc()
      : super(GameMemoryState(
          cards: [],
          cardVisibility: [],
          pairsFound: 0,
          moves: 0,
          numberOfPairs: 0,
          gameStarted: false,
          timer: Stopwatch(),
        )) {
    on<StartGameEvent>(_startGame);
    on<CardTappedEvent>(_cardTapped);
  }

  void _startGame(StartGameEvent event, Emitter<GameMemoryState> emit) {
    var cards = List.generate(event.numberOfPairs * 2,
        (index) => 'Card ${index % event.numberOfPairs}');
    cards.shuffle();

    emit(state.copyWith(
      cards: cards,
      cardVisibility: List.generate(event.numberOfPairs * 2, (_) => false),
      numberOfPairs: event.numberOfPairs,
      gameStarted: true,
      moves: 0,
      pairsFound: 0,
      timer: Stopwatch()..start(),
    ));
  }

  void _cardTapped(CardTappedEvent event, Emitter<GameMemoryState> emit) {
    if (state.cardVisibility.isEmpty ||
        event.cardIndex >= state.cardVisibility.length) return;

    var newVisibility = List<bool>.from(state.cardVisibility);
    newVisibility[event.cardIndex] = true;

    emit(state.copyWith(cardVisibility: newVisibility, moves: state.moves + 1));
  }
}
