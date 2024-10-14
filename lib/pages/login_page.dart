import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nyuumon/bloc/visibility/visibility_cubit.dart';
import 'package:nyuumon/routes/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/icons/logo.png",
                width: MediaQuery.of(context).size.width * 0.75,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                "assets/images/youkoso.png",
                width: MediaQuery.of(context).size.width * 0.3,
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username',
                        hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                        prefixIcon: Icon(
                          Icons.person,
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
                      Text(
                        "Forget password?",
                        style: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 20), // Space between Remember me and the button
                  // Login Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/home');
                        // Add login functionality here
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 108, 230, 113),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          15), // Space between button and create account text
                  // Create an account text
                  GestureDetector(
                    onTap: () {
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
