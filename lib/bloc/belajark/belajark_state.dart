part of 'belajark_bloc.dart';

sealed class BelajarkState extends Equatable {
  const BelajarkState();
  
  @override
  List<Object> get props => [];
}

final class BelajarkInitial extends BelajarkState {}
