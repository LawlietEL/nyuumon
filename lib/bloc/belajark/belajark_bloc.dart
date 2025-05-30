import 'package:flutter_bloc/flutter_bloc.dart';
import 'belajark_event.dart';
import 'belajark_state.dart';

class BelajarKBloc extends Bloc<BelajarKEvent, BelajarKState> {
  BelajarKBloc() : super(BelajarKInitial()) {
    on<LoadKatakanaData>(_onLoadKatakanaData);
    on<LoadDetailHuruf>(_onLoadDetailHuruf);
  }

  void _onLoadKatakanaData(
      LoadKatakanaData event, Emitter<BelajarKState> emit) {
    const vocalList = ['ア', 'イ', 'ウ', 'エ', 'オ'];
    const konsonanList = [
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
      '',
      'ユ',
      '',
      'ヨ',
      'ラ',
      'リ',
      'ル',
      'レ',
      'ロ',
      'ワ',
      '',
      '',
      '',
      'ヲ',
      'ン',
      '',
      '',
      '',
      ''
    ];

    final romajiMapk = {
      'ア': 'a',
      'イ': 'i',
      'ウ': 'u',
      'エ': 'e',
      'オ': 'o',
      'カ': 'ka',
      'キ': 'ki',
      'ク': 'ku',
      'ケ': 'ke',
      'コ': 'ko',
      'サ': 'sa',
      'シ': 'shi',
      'ス': 'su',
      'セ': 'se',
      'ソ': 'so',
      'タ': 'ta',
      'チ': 'chi',
      'ツ': 'tsu',
      'テ': 'te',
      'ト': 'to',
      'ナ': 'na',
      'ニ': 'ni',
      'ヌ': 'nu',
      'ネ': 'ne',
      'ノ': 'no',
      'ハ': 'ha',
      'ヒ': 'hi',
      'フ': 'fu',
      'ヘ': 'he',
      'ホ': 'ho',
      'マ': 'ma',
      'ミ': 'mi',
      'ム': 'mu',
      'メ': 'me',
      'モ': 'mo',
      'ヤ': 'ya',
      'ユ': 'yu',
      'ヨ': 'yo',
      'ラ': 'ra',
      'リ': 'ri',
      'ル': 'ru',
      'レ': 're',
      'ロ': 'ro',
      'ワ': 'wa',
      'ヲ': 'wo',
      'ン': 'n',
    };

    emit(BelajarKLoaded(
      vocalList: vocalList,
      konsonanList: konsonanList,
      romajiMap: romajiMapk,
    ));
  }

  void _onLoadDetailHuruf(LoadDetailHuruf event, Emitter<BelajarKState> emit) {
    final letter = event.letter;
    final imagePath = _imageMap[letter] ?? 'assets/katakana/a.png';

    emit(DetailHurufLoaded(letter: letter, imagePath: imagePath));
  }
}

final Map<String, String> _imageMap = {
  'ア': 'assets/katakana/a.png',
  'イ': 'assets/katakana/i.png',
  'ウ': 'assets/katakana/u.png',
  'エ': 'assets/katakana/e.png',
  'オ': 'assets/katakana/o.png',
  'カ': 'assets/katakana/ka.png',
  'キ': 'assets/katakana/ki.png',
  'ク': 'assets/katakana/ku.png',
  'ケ': 'assets/katakana/ke.png',
  'コ': 'assets/katakana/ko.png',
  'サ': 'assets/katakana/sa.png',
  'シ': 'assets/katakana/shi.png',
  'ス': 'assets/katakana/su.png',
  'セ': 'assets/katakana/se.png',
  'ソ': 'assets/katakana/so.png',
  'タ': 'assets/katakana/ta.png',
  'チ': 'assets/katakana/chi.png',
  'ツ': 'assets/katakana/tsu.png',
  'テ': 'assets/katakana/te.png',
  'ト': 'assets/katakana/to.png',
  'ナ': 'assets/katakana/na.png',
  'ニ': 'assets/katakana/ni.png',
  'ヌ': 'assets/katakana/nu.png',
  'ネ': 'assets/katakana/ne.png',
  'ノ': 'assets/katakana/no.png',
  'ハ': 'assets/katakana/ha.png',
  'ヒ': 'assets/katakana/hi.png',
  'フ': 'assets/katakana/fu.png',
  'ヘ': 'assets/katakana/he.png',
  'ホ': 'assets/katakana/ho.png',
  'マ': 'assets/katakana/ma.png',
  'ミ': 'assets/katakana/mi.png',
  'ム': 'assets/katakana/mu.png',
  'メ': 'assets/katakana/me.png',
  'モ': 'assets/katakana/mo.png',
  'ヤ': 'assets/katakana/ya.png',
  'ユ': 'assets/katakana/yu.png',
  'ヨ': 'assets/katakana/yo.png',
  'ラ': 'assets/katakana/ra.png',
  'リ': 'assets/katakana/ri.png',
  'ル': 'assets/katakana/ru.png',
  'レ': 'assets/katakana/re.png',
  'ロ': 'assets/katakana/ro.png',
  'ワ': 'assets/katakana/wa.png',
  'ヲ': 'assets/katakana/wo.png',
  'ン': 'assets/katakana/n.png'
};
