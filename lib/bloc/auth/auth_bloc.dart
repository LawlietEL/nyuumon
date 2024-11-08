import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nyuumon/routes/router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthStateLogout()) {
    CollectionReference users = _firestore.collection('users');

    // Handler untuk event register
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading());
      try {
        var userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // Tambahkan data pengguna ke Firestore
        await users.doc(userCredential.user!.uid).set({
          'username': event.username,
          'email': event.email,
          'created_at': DateTime.now(),
        });

        emit(AuthStateRegisterSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message ?? 'Registration failed.'));
      } catch (e) {
        emit(AuthStateError('An unexpected error occurred.'));
      }
    });

    // Handler untuk event login
    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());

        var u = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );

        var userDoc =
            await users.where('email', isEqualTo: u.user!.email).get();

        if (userDoc.docs.isNotEmpty) {
          await users.doc(userDoc.docs.first.id).update({
            'updated_at': DateTime.now(),
          });
          print("User updated");
        } else {
          await users.add({
            'name': u.user!.displayName,
            'email': u.user!.email,
            'created_at': DateTime.now(),
            'updated_at': DateTime.now(),
          });
          print("User added");
        }

        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });

    // Handler untuk event logout
    on<AuthEventLogout>((event, emit) async {
      try {
        emit(AuthStateLoading());

        await _auth.signOut();
        emit(AuthStateLogout());
        router.goNamed(Routes.login);
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });

    // Handler untuk event profil
    on<AuthEventProfil>((event, emit) async {
      try {
        emit(AuthStateLoading());
        var email = _auth.currentUser!.email;
        var name = _auth.currentUser?.displayName ?? 'null';
        emit(AuthStateProfil(
          email!,
          name,
        ));
      } on FirebaseException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });

    // Handler untuk event change password
    on<ChangePasswordEvent>(_onChangePassword);
  }

  // Fungsi handler untuk event ChangePasswordEvent
  Future<void> _onChangePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthStateLoading());

      final user = _auth.currentUser;
      if (user == null) {
        emit(AuthStateError('User not logged in'));
        return;
      }

      // Validasi recent password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: event.recentPassword,
      );

      try {
        await user.reauthenticateWithCredential(credential);
      } on FirebaseAuthException {
        emit(AuthChangePasswordError("Recent password is incorrect"));
        return;
      }

      // Update password
      await user.updatePassword(event.newPassword);

      // Optional: Update Firestore (not recommended to store passwords in Firestore)
      await _firestore.collection('users').doc(user.uid).update({
        'password': event.newPassword, // Avoid storing passwords directly
      });

      emit(AuthPasswordChanged());
    } on FirebaseAuthException catch (e) {
      emit(AuthStateError(e.message ?? 'Failed to change password'));
    } catch (e) {
      emit(AuthStateError('An unexpected error occurred.'));
    }
  }
}
