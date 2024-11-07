part of 'auth_bloc.dart';

abstract class AuthState {}

// State -> kondisi saat ini
// 1. AuthStateLogin -> terautentikasi
// 2. AuthStateLogout -> tidak terautentikasi
// 3. AuthStateLoading -> loading ...
// 4. AuthStateError -> gagal login -> dapat error

// Tambahkan state untuk registrasi sukses

//class AuthStateInitial extends AuthState {}

class AuthStateRegisterSuccess extends AuthState {}

class AuthStateError extends AuthState {
  final String errorMessage;

  AuthStateError(this.errorMessage);
}

class AuthStateLogin extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLogout extends AuthState {}

class AuthStateProfil extends AuthState {
  AuthStateProfil(this.email, this.name);

  final String email;
  final String name;
}
