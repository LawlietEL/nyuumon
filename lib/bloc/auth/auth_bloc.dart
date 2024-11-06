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

    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());
        // fungsi untuk login

        var u = await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );
        //Untuk saring user sudah ada atau tidak, sudah login atau tidak
        //if()
        //1. cek uid kedalam firebase
        //2. kalau belum ada, nambah
        //3. kalau sudah ada, update
        print(u);
        await users
            .add({
              'name': u.user!.displayName,
              'email': u.user!.email,
              'created_at': DateTime.now(),
              'updated_at': DateTime.now(),
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));

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
      // fungsi untuk logout
      try {
        emit(AuthStateLoading());
        // fungsi untuk logout
        await auth.signOut();
        emit(AuthStateLogout());
        router.goNamed(Routes.login);
      } on FirebaseAuthException catch (e) {
        // Error dari Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(AuthStateError(e.toString()));
      }
    });
    on<AuthEventProfil>(
      (event, emit) async {
        try {
          emit(AuthStateLoading());
          var email = await auth.currentUser!.email;
          var name = await auth.currentUser?.displayName ?? 'null';
          emit(AuthStateProfil(
            email!,
            name,
          ));
        } on FirebaseException catch (e) {
          // Error dari Firebase Auth
          emit(AuthStateError(e.message.toString()));
        } catch (e) {
          // Error general
          emit(AuthStateError(e.toString()));
        }
      },
    );
  }
}
