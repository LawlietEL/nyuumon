import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'gamememory_event.dart';
import 'gamememory_state.dart';

class GameMemoryBloc extends Bloc<GameMemoryEvent, GameMemoryState> {
  Timer? _timer; // Timer untuk menghitung waktu
  int? firstCardIndex; // Menyimpan index kartu pertama yang dibuka

  GameMemoryBloc()
      : super(GameMemoryState(
          cards: [],
          cardVisibility: [],
          pairsFound: 0,
          moves: 0,
          numberOfPairs: 0,
          gameStarted: false,
          gameFinished: false,
          elapsedTime: 0,
        )) {
    on<StartGameEvent>(_startGame);
    on<CardTappedEvent>(_cardTapped);
    on<UpdateTimerEvent>(_updateTimer);
    on<ResetGameEvent>(_resetGame);
  }

  // **Memulai Game dengan jumlah soal yang dipilih**
  void _startGame(StartGameEvent event, Emitter<GameMemoryState> emit) {
    List<String> hiragana = ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ'];
    List<String> katakana = ['ア', 'イ', 'ウ', 'エ', 'オ', 'カ', 'キ', 'ク', 'ケ', 'コ'];

    List<String> selectedHiragana = hiragana.sublist(0, event.numberOfPairs);
    List<String> selectedKatakana = katakana.sublist(0, event.numberOfPairs);

    List<String> cards = [...selectedHiragana, ...selectedKatakana];
    cards.shuffle();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateTimerEvent());
    });

    emit(state.copyWith(
      cards: cards,
      cardVisibility: List.generate(event.numberOfPairs * 2, (_) => false),
      numberOfPairs: event.numberOfPairs,
      gameStarted: true,
      gameFinished: false,
      moves: 0,
      pairsFound: 0,
      elapsedTime: 0,
    ));
  }

  // **Logika Membuka dan Mencocokkan Kartu**
  void _cardTapped(CardTappedEvent event, Emitter<GameMemoryState> emit) {
    var newVisibility = List<bool>.from(state.cardVisibility);
    newVisibility[event.cardIndex] = true;

    if (firstCardIndex == null) {
      firstCardIndex = event.cardIndex;
    } else {
      var firstCard = state.cards[firstCardIndex!];
      var secondCard = state.cards[event.cardIndex];

      bool isMatch = ((firstCard == 'あ' && secondCard == 'ア') ||
          (firstCard == 'ア' && secondCard == 'あ') ||
          (firstCard == 'い' && secondCard == 'イ') ||
          (firstCard == 'イ' && secondCard == 'い') ||
          (firstCard == 'う' && secondCard == 'ウ') ||
          (firstCard == 'ウ' && secondCard == 'う') ||
          (firstCard == 'え' && secondCard == 'エ') ||
          (firstCard == 'エ' && secondCard == 'え'));

      if (isMatch) {
        emit(state.copyWith(pairsFound: state.pairsFound + 1));
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          newVisibility[firstCardIndex!] = false;
          newVisibility[event.cardIndex] = false;
          emit(state.copyWith(cardVisibility: newVisibility));
        });
      }

      firstCardIndex = null;
    }

    emit(state.copyWith(cardVisibility: newVisibility, moves: state.moves + 1));

    // **Jika semua pasangan sudah ditemukan, game selesai**
    if (state.pairsFound + 1 == state.numberOfPairs) {
      _timer?.cancel();
      emit(state.copyWith(gameFinished: true));
    }
  }

  // **Memperbarui Timer Setiap Detik**
  void _updateTimer(UpdateTimerEvent event, Emitter<GameMemoryState> emit) {
    emit(state.copyWith(elapsedTime: state.elapsedTime + 1));
  }

  // **Mereset Game ke Kondisi Awal**
  void _resetGame(ResetGameEvent event, Emitter<GameMemoryState> emit) {
    _timer?.cancel();
    firstCardIndex = null;
    emit(GameMemoryState(
      cards: [],
      cardVisibility: [],
      pairsFound: 0,
      moves: 0,
      numberOfPairs: 0,
      gameStarted: false,
      gameFinished: false,
      elapsedTime: 0,
    ));
  }
}
