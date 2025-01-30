import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musifier/auth/auth.dart';
import 'package:musifier/pages/homePage.dart';
import 'package:musifier/widgets/errorMessage.dart';
import '../widgets/button.dart';
import '../widgets/textInput.dart';
import 'signupPage.dart';
import 'forgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      await Auth().signInWithEmailAndPassword(
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
                  'Welcome Back to Musifier!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                  ),
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
                ErrorMessage(message: errorMessage),
                const SizedBox(height: 50),
                CustomButton(
                    text: 'Log In',
                    onPressed: () async {
                      await signInWithEmailAndPassword(context);
                    }),
                const SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Nunito-Regular',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
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
