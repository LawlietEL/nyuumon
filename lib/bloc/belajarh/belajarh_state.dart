abstract class BelajarHState {}

class BelajarHInitial extends BelajarHState {}

class BelajarHLoaded extends BelajarHState {
  final List<String> vocalList;
  final List<String> konsonanList;

  BelajarHLoaded({required this.vocalList, required this.konsonanList});
}

class DetailHurufLoaded extends BelajarHState {
  final String letter;
  final String imagePath;

  DetailHurufLoaded({required this.letter, required this.imagePath});
}
