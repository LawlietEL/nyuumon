import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'gamememory_event.dart';
import 'gamememory_state.dart';

class GameMemoryBloc extends Bloc<GameMemoryEvent, GameMemoryState> {
  Timer? _timer;
  int? firstCardIndex;
  int? secondCardIndex;
  bool isChecking = false;
  bool hasShownMismatchNotification =
      false; // Flag untuk mengontrol notifikasi salah pasangan

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
    List<String> hiragana = [
      'あ',
      'い',
      'う',
      'え',
      'お',
      'か',
      'き',
      'く',
      'け',
      'こ',
      'さ',
      'し',
      'す',
      'せ',
      'そ',
      'た',
      'ち',
      'つ',
      'て',
      'と',
      'な',
      'に',
      'ぬ',
      'ね',
      'の',
      'は',
      'ひ',
      'ふ',
      'へ',
      'ほ',
      'ま',
      'み',
      'む',
      'め',
      'も',
      'や',
      'ゆ',
      'よ',
      'ら',
      'り',
      'る',
      'れ',
      'ろ',
      'わ',
      'を',
      'ん'
    ];
    List<String> katakana = [
      'ア',
      'イ',
      'ウ',
      'エ',
      'オ',
      'カ',
      'キ',
      'ク',
      'ケ',
      'コ',
      'サ',
      'シ',
      'ス',
      'セ',
      'ソ',
      'タ',
      'チ',
      'ツ',
      'テ',
      'ト',
      'ナ',
      'ニ',
      'ヌ',
      'ネ',
      'ノ',
      'ハ',
      'ヒ',
      'フ',
      'ヘ',
      'ホ',
      'マ',
      'ミ',
      'ム',
      'メ',
      'モ',
      'ヤ',
      'ユ',
      'ヨ',
      'ラ',
      'リ',
      'ル',
      'レ',
      'ロ',
      'ワ',
      'ヲ',
      'ン'
    ];

    List<String> selectedHiragana = hiragana.sublist(0, event.numberOfPairs);
    List<String> selectedKatakana = katakana.sublist(0, event.numberOfPairs);

    List<String> cards = [...selectedHiragana, ...selectedKatakana];
    cards.shuffle();

    emit(state.copyWith(
      cards: cards,
      cardVisibility: List.generate(
          cards.length, (_) => true), // Semua kartu langsung terbuka
      numberOfPairs: event.numberOfPairs,
      gameStarted: true,
      gameFinished: false,
      moves: 0,
      pairsFound: 0,
      elapsedTime: 0,
    ));

    // Mulai timer
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateTimerEvent());
    });
  }

  // **Logika Memilih dan Mencocokkan Kartu**
  void _cardTapped(CardTappedEvent event, Emitter<GameMemoryState> emit) {
    if (isChecking) return; // Tidak bisa klik kartu lain saat menunggu proses

    // Tambahkan jumlah gerakan setiap kali user klik kartu
    emit(state.copyWith(moves: state.moves + 1));

    if (firstCardIndex == null) {
      firstCardIndex = event.cardIndex;
    } else {
      secondCardIndex = event.cardIndex;
      isChecking = true;

      var firstCard = state.cards[firstCardIndex!];
      var secondCard = state.cards[secondCardIndex!];

      bool isMatch = ((firstCard == 'あ' && secondCard == 'ア') ||
          (firstCard == 'ア' && secondCard == 'あ') ||
          (firstCard == 'い' && secondCard == 'イ') ||
          (firstCard == 'イ' && secondCard == 'い') ||
          (firstCard == 'う' && secondCard == 'ウ') ||
          (firstCard == 'ウ' && secondCard == 'う') ||
          (firstCard == 'え' && secondCard == 'エ') ||
          (firstCard == 'エ' && secondCard == 'え') ||
          (firstCard == 'お' && secondCard == 'オ') ||
          (firstCard == 'オ' && secondCard == 'お') ||
          (firstCard == 'か' && secondCard == 'カ') ||
          (firstCard == 'カ' && secondCard == 'か') ||
          (firstCard == 'き' && secondCard == 'キ') ||
          (firstCard == 'キ' && secondCard == 'き') ||
          (firstCard == 'く' && secondCard == 'ク') ||
          (firstCard == 'ク' && secondCard == 'く') ||
          (firstCard == 'け' && secondCard == 'ケ') ||
          (firstCard == 'ケ' && secondCard == 'け') ||
          (firstCard == 'こ' && secondCard == 'コ') ||
          (firstCard == 'コ' && secondCard == 'こ') ||
          (firstCard == 'さ' && secondCard == 'サ') ||
          (firstCard == 'サ' && secondCard == 'さ') ||
          (firstCard == 'し' && secondCard == 'シ') ||
          (firstCard == 'シ' && secondCard == 'し') ||
          (firstCard == 'す' && secondCard == 'ス') ||
          (firstCard == 'ス' && secondCard == 'す') ||
          (firstCard == 'せ' && secondCard == 'セ') ||
          (firstCard == 'セ' && secondCard == 'せ') ||
          (firstCard == 'そ' && secondCard == 'ソ') ||
          (firstCard == 'ソ' && secondCard == 'そ') ||
          (firstCard == 'た' && secondCard == 'タ') ||
          (firstCard == 'タ' && secondCard == 'た') ||
          (firstCard == 'ち' && secondCard == 'チ') ||
          (firstCard == 'チ' && secondCard == 'ち') ||
          (firstCard == 'つ' && secondCard == 'ツ') ||
          (firstCard == 'ツ' && secondCard == 'つ') ||
          (firstCard == 'て' && secondCard == 'テ') ||
          (firstCard == 'テ' && secondCard == 'て') ||
          (firstCard == 'と' && secondCard == 'ト') ||
          (firstCard == 'ト' && secondCard == 'と') ||
          (firstCard == 'な' && secondCard == 'ナ') ||
          (firstCard == 'ナ' && secondCard == 'な') ||
          (firstCard == 'に' && secondCard == 'ニ') ||
          (firstCard == 'ニ' && secondCard == 'に') ||
          (firstCard == 'ぬ' && secondCard == 'ヌ') ||
          (firstCard == 'ヌ' && secondCard == 'ぬ') ||
          (firstCard == 'ね' && secondCard == 'ネ') ||
          (firstCard == 'ネ' && secondCard == 'ね') ||
          (firstCard == 'の' && secondCard == 'ノ') ||
          (firstCard == 'ノ' && secondCard == 'の') ||
          (firstCard == 'は' && secondCard == 'ハ') ||
          (firstCard == 'ハ' && secondCard == 'は') ||
          (firstCard == 'ひ' && secondCard == 'ヒ') ||
          (firstCard == 'ヒ' && secondCard == 'ひ') ||
          (firstCard == 'ふ' && secondCard == 'フ') ||
          (firstCard == 'フ' && secondCard == 'ふ') ||
          (firstCard == 'へ' && secondCard == 'ヘ') ||
          (firstCard == 'ヘ' && secondCard == 'へ') ||
          (firstCard == 'ほ' && secondCard == 'ホ') ||
          (firstCard == 'ホ' && secondCard == 'ほ') ||
          (firstCard == 'ま' && secondCard == 'マ') ||
          (firstCard == 'マ' && secondCard == 'ま') ||
          (firstCard == 'み' && secondCard == 'ミ') ||
          (firstCard == 'ミ' && secondCard == 'み') ||
          (firstCard == 'む' && secondCard == 'ム') ||
          (firstCard == 'ム' && secondCard == 'む') ||
          (firstCard == 'め' && secondCard == 'メ') ||
          (firstCard == 'メ' && secondCard == 'め') ||
          (firstCard == 'も' && secondCard == 'モ') ||
          (firstCard == 'モ' && secondCard == 'も') ||
          (firstCard == 'や' && secondCard == 'ヤ') ||
          (firstCard == 'ヤ' && secondCard == 'や') ||
          (firstCard == 'ゆ' && secondCard == 'ユ') ||
          (firstCard == 'ユ' && secondCard == 'ゆ') ||
          (firstCard == 'よ' && secondCard == 'ヨ') ||
          (firstCard == 'ヨ' && secondCard == 'よ') ||
          (firstCard == 'ら' && secondCard == 'ラ') ||
          (firstCard == 'ラ' && secondCard == 'ら') ||
          (firstCard == 'り' && secondCard == 'リ') ||
          (firstCard == 'リ' && secondCard == 'り') ||
          (firstCard == 'る' && secondCard == 'ル') ||
          (firstCard == 'ル' && secondCard == 'る') ||
          (firstCard == 'れ' && secondCard == 'レ') ||
          (firstCard == 'レ' && secondCard == 'れ') ||
          (firstCard == 'ろ' && secondCard == 'ロ') ||
          (firstCard == 'ロ' && secondCard == 'ろ') ||
          (firstCard == 'わ' && secondCard == 'ワ') ||
          (firstCard == 'ワ' && secondCard == 'わ') ||
          (firstCard == 'を' && secondCard == 'ヲ') ||
          (firstCard == 'ヲ' && secondCard == 'を') ||
          (firstCard == 'ん' && secondCard == 'ン') ||
          (firstCard == 'ン' && secondCard == 'ん'));

      if (isMatch) {
        var newCards = List<String>.from(state.cards);
        newCards[firstCardIndex!] = '';
        newCards[secondCardIndex!] = '';

        emit(state.copyWith(
          cards: newCards,
          pairsFound: state.pairsFound + 1,
          moves: state.moves + 1,
        ));

        // **Cek apakah semua pasangan sudah ditemukan dan game selesai**
        if (state.pairsFound + 1 == state.numberOfPairs) {
          _timer?.cancel(); // **Hentikan timer saat game selesai**
          emit(state.copyWith(gameFinished: true));
        }
      } else {}

      firstCardIndex = null;
      secondCardIndex = null;
      isChecking = false;
    }
  }

  // **Memperbarui Timer**
  void _updateTimer(UpdateTimerEvent event, Emitter<GameMemoryState> emit) {
    emit(state.copyWith(elapsedTime: state.elapsedTime + 1));
  }

  // **Mereset Game ke Kondisi Awal**
  void _resetGame(ResetGameEvent event, Emitter<GameMemoryState> emit) {
    _timer?.cancel();
    firstCardIndex = null;
    secondCardIndex = null;
    isChecking = false;
    hasShownMismatchNotification = false;
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
