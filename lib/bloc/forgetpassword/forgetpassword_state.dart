part of 'forgetpassword_bloc.dart';

sealed class ForgetpasswordState extends Equatable {
  const ForgetpasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetpasswordInitial extends ForgetpasswordState {}

final class ForgetpasswordLoading extends ForgetpasswordState {}

final class ForgetpasswordSuccess extends ForgetpasswordState {}

final class ForgetpasswordError extends ForgetpasswordState {
  final String message;

  const ForgetpasswordError(this.message);

  @override
  List<Object> get props => [message];
}
