abstract class BelajarKState {}

class BelajarKInitial extends BelajarKState {}

class BelajarKLoaded extends BelajarKState {
  final List<String> vocalList;
  final List<String> konsonanList;

  BelajarKLoaded({required this.vocalList, required this.konsonanList});
}

class DetailHurufLoaded extends BelajarKState {
  final String letter;
  final String imagePath;

  DetailHurufLoaded({required this.letter, required this.imagePath});
}
