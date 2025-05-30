import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc
    extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc() : super(ForgetpasswordInitial()) {
    on<ForgetpasswordSendEmailEvent>((event, emit) async {
      emit(ForgetpasswordLoading());
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
        emit(ForgetpasswordSuccess());
      } catch (e) {
        emit(ForgetpasswordError('Gagal mengirim email: ${e.toString()}'));
      }
    });
  }
}
