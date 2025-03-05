abstract class BelajarKEvent {}

class LoadKatakanaData extends BelajarKEvent {}

class LoadDetailHuruf extends BelajarKEvent {
  final String letter;
  LoadDetailHuruf(this.letter);
}
