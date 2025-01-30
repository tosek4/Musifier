import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musifier/auth/auth.dart';
import 'package:musifier/pages/homePage.dart';
import 'package:musifier/widgets/errorMessage.dart';
import '../widgets/button.dart';
import '../widgets/textInput.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B37),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome to Musifier!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                  ),
                ),
                const SizedBox(height: 40),
                CustomInputField(
                  controller: _nameController,
                  hintText: 'Enter your name',
                  icon: Icons.person_outline,
                  labelText: 'Full name',
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                  labelText: 'Email address',
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  labelText: 'Password',
                ),
                const SizedBox(height: 40),
                CustomButton(
                    text: 'Sign Up',
                    onPressed: () async {
                      createUserWithEmailAndPassword(context);
                    }),
                const SizedBox(height: 80),
                ErrorMessage(message: errorMessage),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Nunito-Regular',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Color(0xFF6156E2),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
