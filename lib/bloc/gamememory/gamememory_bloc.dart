import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'gamememory_event.dart';
import 'gamememory_state.dart';

class GameMemoryBloc extends Bloc<GameMemoryEvent, GameMemoryState> {
  Timer? _timer;
  int? firstCardIndex; // Index kartu pertama yang diklik
  int? secondCardIndex; // Index kartu kedua yang diklik
  bool isChecking = false; // Status apakah sedang memeriksa kartu kedua

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
    on<CloseCardsEvent>(_closeCards);
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

    emit(state.copyWith(
      cards: cards,
      cardVisibility:
          List.generate(cards.length, (_) => true), // Semua kartu terbuka
      numberOfPairs: event.numberOfPairs,
      gameStarted: true,
      gameFinished: false,
      moves: 0,
      pairsFound: 0,
      elapsedTime: 0,
    ));

    Future.delayed(const Duration(seconds: 5), () {
      add(CloseCardsEvent()); // Menggunakan event untuk menutup kartu
    });
  }

  // **Menutup semua kartu setelah 5 detik**
  void _closeCards(CloseCardsEvent event, Emitter<GameMemoryState> emit) {
    emit(state.copyWith(
      cardVisibility: List.generate(state.cards.length, (_) => false),
    ));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateTimerEvent());
    });
  }

  // **Logika Membuka dan Mencocokkan Kartu**
  void _cardTapped(CardTappedEvent event, Emitter<GameMemoryState> emit) {
    if (isChecking)
      return; // Tidak bisa klik kartu lain saat kartu kedua belum ditutup

    var newVisibility = List<bool>.from(state.cardVisibility);

    // **Jika kartu sudah terbuka dan itu adalah kartu kedua, maka kartu ditutup kembali**
    if (secondCardIndex == event.cardIndex) {
      newVisibility[event.cardIndex] = false;
      secondCardIndex = null;
      emit(state.copyWith(cardVisibility: newVisibility));
      return;
    }

    // **Klik kartu pertama**
    if (firstCardIndex == null) {
      firstCardIndex = event.cardIndex;
      newVisibility[event.cardIndex] = true;
    }
    // **Klik kartu kedua**
    else if (secondCardIndex == null) {
      secondCardIndex = event.cardIndex;
      newVisibility[event.cardIndex] = true;
      isChecking =
          true; // Kunci interaksi sampai kartu cocok atau ditutup kembali

      var firstCard = state.cards[firstCardIndex!];
      var secondCard = state.cards[secondCardIndex!];

      bool isMatch = ((firstCard == 'あ' && secondCard == 'ア') ||
          (firstCard == 'ア' && secondCard == 'あ') ||
          (firstCard == 'い' && secondCard == 'イ') ||
          (firstCard == 'イ' && secondCard == 'い') ||
          (firstCard == 'う' && secondCard == 'ウ') ||
          (firstCard == 'ウ' && secondCard == 'う') ||
          (firstCard == 'え' && secondCard == 'エ') ||
          (firstCard == 'エ' && secondCard == 'え'));

      if (isMatch) {
        emit(state.copyWith(
          pairsFound: state.pairsFound + 1,
        ));
        firstCardIndex = null;
        secondCardIndex = null;
        isChecking = false;
      }
    }

    emit(state.copyWith(cardVisibility: newVisibility, moves: state.moves + 1));

    // **Jika semua pasangan sudah ditemukan, permainan selesai**
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
    secondCardIndex = null;
    isChecking = false;
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
