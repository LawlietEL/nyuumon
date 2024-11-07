import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nyuumon/routes/router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

// Handler untuk event register
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading());
      try {
        var userCredential = await auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // Tambahkan data pengguna ke Firestore
        await users.doc(userCredential.user!.uid).set({
          'username': event.username,
          'email': event.email,
          'created_at': DateTime.now(),
        });

        // Pencetakan sukses jika berhasil
        emit(AuthStateRegisterSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message ?? 'Registration failed.'));
      } catch (e) {
        emit(AuthStateError('An unexpected error occurred.'));
      }
    });

    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());

        // Fungsi untuk login
        var u = await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );

        // Cek apakah user sudah ada di database Firestore
        var userDoc =
            await users.where('email', isEqualTo: u.user!.email).get();

        if (userDoc.docs.isNotEmpty) {
          // Jika user sudah ada, update kolom updated_at
          await users.doc(userDoc.docs.first.id).update({
            'updated_at': DateTime.now(),
          });
          print("User updated");
        } else {
          // Jika user belum ada, tambahkan data baru
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
        // Error dari Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(AuthStateError(e.toString()));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      try {
        emit(AuthStateLoading());

        // Fungsi untuk logout
        await auth.signOut();
        emit(AuthStateLogout());
        router.goNamed(Routes.login);
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });

    on<AuthEventProfil>(
      (event, emit) async {
        try {
          emit(AuthStateLoading());
          var email = auth.currentUser!.email;
          var name = auth.currentUser?.displayName ?? 'null';
          emit(AuthStateProfil(
            email!,
            name,
          ));
        } on FirebaseException catch (e) {
          emit(AuthStateError(e.message.toString()));
        } catch (e) {
          emit(AuthStateError(e.toString()));
        }
      },
    );
  }
}
