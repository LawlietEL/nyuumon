import 'package:flutter_bloc/flutter_bloc.dart';
import 'belajarh_event.dart';
import 'belajarh_state.dart';

class BelajarHBloc extends Bloc<BelajarHEvent, BelajarHState> {
  BelajarHBloc() : super(BelajarHInitial()) {
    on<LoadHiraganaData>(_onLoadHiraganaData);
    on<LoadDetailHuruf>(_onLoadDetailHuruf);
  }

  void _onLoadHiraganaData(
      LoadHiraganaData event, Emitter<BelajarHState> emit) {
    const vocalList = ['あ', 'い', 'う', 'え', 'お'];
    const konsonanList = [
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
      '',
      'ゆ',
      '',
      'よ',
      'ら',
      'り',
      'る',
      'れ',
      'ろ',
      'わ',
      '',
      '',
      '',
      'を',
      'ん',
      '',
      '',
      '',
      ''
    ];

    final romajiMap = {
      'あ': 'a',
      'い': 'i',
      'う': 'u',
      'え': 'e',
      'お': 'o',
      'か': 'ka',
      'き': 'ki',
      'く': 'ku',
      'け': 'ke',
      'こ': 'ko',
      'さ': 'sa',
      'し': 'shi',
      'す': 'su',
      'せ': 'se',
      'そ': 'so',
      'た': 'ta',
      'ち': 'chi',
      'つ': 'tsu',
      'て': 'te',
      'と': 'to',
      'な': 'na',
      'に': 'ni',
      'ぬ': 'nu',
      'ね': 'ne',
      'の': 'no',
      'は': 'ha',
      'ひ': 'hi',
      'ふ': 'fu',
      'へ': 'he',
      'ほ': 'ho',
      'ま': 'ma',
      'み': 'mi',
      'む': 'mu',
      'め': 'me',
      'も': 'mo',
      'や': 'ya',
      'ゆ': 'yu',
      'よ': 'yo',
      'ら': 'ra',
      'り': 'ri',
      'る': 'ru',
      'れ': 're',
      'ろ': 'ro',
      'わ': 'wa',
      'を': 'wo',
      'ん': 'n'
    };

    emit(BelajarHLoaded(
      vocalList: vocalList,
      konsonanList: konsonanList,
      romajiMap: romajiMap,
    ));
  }

  void _onLoadDetailHuruf(LoadDetailHuruf event, Emitter<BelajarHState> emit) {
    final letter = event.letter;
    final imagePath = _imageMap[letter] ?? 'assets/hiragana/a.png';

    emit(DetailHurufLoaded(letter: letter, imagePath: imagePath));
  }
}

// Mapping huruf ke file gambar
final Map<String, String> _imageMap = {
  'あ': 'assets/hiragana/a.png',
  'い': 'assets/hiragana/i.png',
  'う': 'assets/hiragana/u.png',
  'え': 'assets/hiragana/e.png',
  'お': 'assets/hiragana/o.png',
  'か': 'assets/hiragana/ka.png',
  'き': 'assets/hiragana/ki.png',
  'く': 'assets/hiragana/ku.png',
  'け': 'assets/hiragana/ke.png',
  'こ': 'assets/hiragana/ko.png',
  'さ': 'assets/hiragana/sa.png',
  'し': 'assets/hiragana/shi.png',
  'す': 'assets/hiragana/su.png',
  'せ': 'assets/hiragana/se.png',
  'そ': 'assets/hiragana/so.png',
  'た': 'assets/hiragana/ta.png',
  'ち': 'assets/hiragana/chi.png',
  'つ': 'assets/hiragana/tsu.png',
  'て': 'assets/hiragana/te.png',
  'と': 'assets/hiragana/to.png',
  'な': 'assets/hiragana/na.png',
  'に': 'assets/hiragana/ni.png',
  'ぬ': 'assets/hiragana/nu.png',
  'ね': 'assets/hiragana/ne.png',
  'の': 'assets/hiragana/no.png',
  'は': 'assets/hiragana/ha.png',
  'ひ': 'assets/hiragana/hi.png',
  'ふ': 'assets/hiragana/fu.png',
  'へ': 'assets/hiragana/he.png',
  'ほ': 'assets/hiragana/ho.png',
  'ま': 'assets/hiragana/ma.png',
  'み': 'assets/hiragana/mi.png',
  'む': 'assets/hiragana/mu.png',
  'め': 'assets/hiragana/me.png',
  'も': 'assets/hiragana/mo.png',
  'や': 'assets/hiragana/ya.png',
  'ゆ': 'assets/hiragana/yu.png',
  'よ': 'assets/hiragana/yo.png',
  'ら': 'assets/hiragana/ra.png',
  'り': 'assets/hiragana/ri.png',
  'る': 'assets/hiragana/ru.png',
  'れ': 'assets/hiragana/re.png',
  'ろ': 'assets/hiragana/ro.png',
  'わ': 'assets/hiragana/wa.png',
  'を': 'assets/hiragana/wo.png',
  'ん': 'assets/hiragana/n.png',
};
