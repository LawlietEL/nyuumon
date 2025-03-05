import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/auth/auth_bloc.dart';
import 'package:nyuumon/bloc/visibility/visibility_cubit.dart';
import 'package:nyuumon/routes/router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/icons/logo.png",
                width: MediaQuery.of(context).size.width * 0.70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Image.asset(
                "assets/images/youkoso.png",
                width: MediaQuery.of(context).size.width * 0.27,
              ),
            ),
            SizedBox(height: 15), // Padding between image and input fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Username TextField
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextField(
                      autocorrect: false,
                      controller: emailC,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF8A8888),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  // Password TextField
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: BlocBuilder<VisibilityCubit, bool>(
                      builder: (context, state) {
                        return TextField(
                          autocorrect: false,
                          controller: passC,
                          obscureText: state,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(color: Color(0xFF8A8888)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFF8A8888),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<VisibilityCubit>().change();
                                },
                                icon: Icon(state == true
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Remember me and Forget password row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Remember me",
                            style: TextStyle(color: Colors.blue[400]),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/login/forget_password');
                          print('Forget Password Ditekan');
                        },
                        child: Text(
                          "Forget password?",
                          style: TextStyle(
                            color: Color(0xFF8A8888),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10), // Space between Remember me and the button
                  // Login Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        // Cek apakah kolom email atau password kosong
                        if (emailC.text.isEmpty || passC.text.isEmpty) {
                          // Tampilkan pesan error jika kolom kosong
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "The email and password fields must be filled in!"),
                            ),
                          );
                        } else {
                          // Kirim event login jika kedua kolom terisi
                          context.read<AuthBloc>().add(
                                AuthEventLogin(emailC.text, passC.text),
                              );
                        }
                      },
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthStateLogin) {
                            context.goNamed(Routes.home);
                          }
                          if (state is AuthStateError) {
                            // Cek jika error terjadi karena email atau password salah
                            String errorMessage = state.errorMessage;

                            // Jika error berhubungan dengan email atau password salah
                            if (errorMessage.contains('email') ||
                                errorMessage.contains('password')) {
                              errorMessage =
                                  "Incorrect email or password, please check again!";
                            }

                            // Tampilkan error message yang disesuaikan
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthStateLoading) {
                            return const Text("LOADING...");
                          }
                          return const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          );
                        },
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 108, 230, 113),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          10), // Space between button and create account text
                  // Create an account text
                  GestureDetector(
                    onTap: () {
                      context.push('/create_account');
                      print('Create Account Ditekan');
                      // Handle account creation process
                    },
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
