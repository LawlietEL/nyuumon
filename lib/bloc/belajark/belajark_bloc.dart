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
      'カ', 'キ', 'ク', 'ケ', 'コ', // Baris 1
      'サ', 'シ', 'ス', 'セ', 'ソ', // Baris 2
      'タ', 'チ', 'ツ', 'テ', 'ト', // Baris 3
      'ナ', 'ニ', 'ヌ', 'ネ', 'ノ', // Baris 4
      'ハ', 'ヒ', 'フ', 'ヘ', 'ホ', // Baris 5
      'マ', 'ミ', 'ム', 'メ', 'モ', // Baris 6
      'ヤ', '', 'ユ', '', 'ヨ', // Baris 7
      'ラ', 'リ', 'ル', 'レ', 'ロ', // Baris 8
      'ワ', '', '', '', 'ヲ', // Baris 9
      'ン', '', '', '', '' // Baris 10
    ];

    emit(BelajarKLoaded(vocalList: vocalList, konsonanList: konsonanList));
  }

  void _onLoadDetailHuruf(LoadDetailHuruf event, Emitter<BelajarKState> emit) {
    final letter = event.letter;
    final imagePath = _imageMap[letter] ?? 'assets/hiragana/a.png';

    emit(DetailHurufLoaded(letter: letter, imagePath: imagePath));
  }
}

final Map<String, String> _imageMap = {
  'あ': 'assets/katakana/a.png',
  'い': 'assets/katakana/i.png',
  'う': 'assets/katakana/u.png',
  'え': 'assets/katakana/e.png',
  'お': 'assets/katakana/o.png',
  'か': 'assets/katakana/ka.png',
  'き': 'assets/katakana/ki.png',
  'く': 'assets/katakana/ku.png',
  'け': 'assets/katakana/ke.png',
  'こ': 'assets/katakana/ko.png',
  'さ': 'assets/katakana/sa.png',
  'し': 'assets/katakana/shi.png',
  'す': 'assets/katakana/su.png',
  'せ': 'assets/katakana/se.png',
  'そ': 'assets/katakana/so.png',
  'た': 'assets/katakana/ta.png',
  'ち': 'assets/katakana/chi.png',
  'つ': 'assets/katakana/tsu.png',
  'て': 'assets/katakana/te.png',
  'と': 'assets/katakana/to.png',
  'な': 'assets/katakana/na.png',
  'に': 'assets/katakana/ni.png',
  'ぬ': 'assets/katakana/nu.png',
  'ね': 'assets/katakana/ne.png',
  'の': 'assets/katakana/no.png',
  'は': 'assets/katakana/ha.png',
  'ひ': 'assets/katakana/hi.png',
  'ふ': 'assets/katakana/fu.png',
  'へ': 'assets/katakana/he.png',
  'ほ': 'assets/katakana/ho.png',
  'ま': 'assets/katakana/ma.png',
  'み': 'assets/katakana/mi.png',
  'む': 'assets/katakana/mu.png',
  'め': 'assets/katakana/me.png',
  'も': 'assets/katakana/mo.png',
  'や': 'assets/katakana/ya.png',
  'ゆ': 'assets/katakana/yu.png',
  'よ': 'assets/katakana/yo.png',
  'ら': 'assets/katakana/ra.png',
  'り': 'assets/katakana/ri.png',
  'る': 'assets/katakana/ru.png',
  'れ': 'assets/katakana/re.png',
  'ろ': 'assets/katakana/ro.png',
  'わ': 'assets/katakana/wa.png',
  'を': 'assets/katakana/wo.png',
  'ん': 'assets/katakana/n.png',
};
