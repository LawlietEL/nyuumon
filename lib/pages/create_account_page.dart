import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

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
                width: MediaQuery.of(context).size.width * 0.75,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
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
                    height: MediaQuery.of(context).size.height * 0.07,
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
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                        prefixIcon: Icon(
                          Icons.lock,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(color: Color(0xFF8A8888)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF8A8888),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ), // Remember me and Forget password row
                  SizedBox(
                      height: 15), // Space between Remember me and the button
                  // Login Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add login functionality here
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 108, 230, 113),
                        padding: EdgeInsets.symmetric(vertical: 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          20), // Space between button and create account text
                  // Create an account text
                  GestureDetector(
                    onTap: () {
                      // Handle account creation process
                    },
                    child: Text(
                      'Back to Login Page',
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
