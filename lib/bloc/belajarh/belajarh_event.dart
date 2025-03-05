abstract class BelajarHEvent {}

class LoadHiraganaData extends BelajarHEvent {}

class LoadDetailHuruf extends BelajarHEvent {
  final String letter;
  LoadDetailHuruf(this.letter);
}
