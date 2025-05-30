part of 'forgetpassword_bloc.dart';

sealed class ForgetpasswordEvent extends Equatable {
  const ForgetpasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgetpasswordSendEmailEvent extends ForgetpasswordEvent {
  final String email;

  const ForgetpasswordSendEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}
