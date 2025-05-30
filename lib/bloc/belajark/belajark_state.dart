abstract class BelajarKState {}

class BelajarKInitial extends BelajarKState {}

class BelajarKLoaded extends BelajarKState {
  final List<String> vocalList;
  final List<String> konsonanList;
  // Tambahan: Map huruf ke romaji (huruf latin)
  final Map<String, String> romajiMap;

  BelajarKLoaded({
    required this.vocalList,
    required this.konsonanList,
    required this.romajiMap,
  });
}

class DetailHurufLoaded extends BelajarKState {
  final String letter;
  final String imagePath;

  DetailHurufLoaded({required this.letter, required this.imagePath});
}
