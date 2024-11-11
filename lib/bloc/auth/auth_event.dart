part of 'auth_bloc.dart';

abstract class AuthEvent {}

// Event -> action / aksi / tindakan
// 1. AuthEventLogin -> melakukan tindakan login
// 2. AuthEventLogout -> melakukan tindakan logout
//3. Profil --> Untuk menaggil data ke halam profil
//4. Register --> Mendaftarkan user baru

class AuthEventRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthEventRegister({
    required this.username,
    required this.email,
    required this.password,
  });
}

class AuthEventLogin extends AuthEvent {
  AuthEventLogin(this.email, this.pass);
  final String email;
  final String pass;
}

class AuthEventProfilUser extends AuthEvent {}

class AuthEventLogout extends AuthEvent {}

class ChangePasswordEvent extends AuthEvent {
  final String recentPassword;
  final String newPassword;

  ChangePasswordEvent({
    required this.recentPassword,
    required this.newPassword,
  });
}
