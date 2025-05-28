// State untuk BLoC Belajar Hiragana
abstract class BelajarHState {}

class BelajarHInitial extends BelajarHState {}

class BelajarHLoaded extends BelajarHState {
  final List<String> vocalList;
  final List<String> konsonanList;

  // Tambahan: Map huruf ke romaji (huruf latin)
  final Map<String, String> romajiMap;

  BelajarHLoaded({
    required this.vocalList,
    required this.konsonanList,
    required this.romajiMap,
  });
}

class DetailHurufLoaded extends BelajarHState {
  final String letter;
  final String imagePath;

  DetailHurufLoaded({required this.letter, required this.imagePath});
}
