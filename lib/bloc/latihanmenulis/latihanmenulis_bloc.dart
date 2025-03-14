import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'latihanmenulis_event.dart';
part 'latihanmenulis_state.dart';

class LatihanmenulisBloc extends Bloc<LatihanmenulisEvent, LatihanmenulisState> {
  LatihanmenulisBloc() : super(LatihanmenulisInitial()) {
    on<LatihanmenulisEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
