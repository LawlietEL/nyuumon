import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'belajark_event.dart';
part 'belajark_state.dart';

class BelajarkBloc extends Bloc<BelajarkEvent, BelajarkState> {
  BelajarkBloc() : super(BelajarkInitial()) {
    on<BelajarkEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
