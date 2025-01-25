import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/textInput.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
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
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 40),
                CustomInputField(
                  controller: _nameController,
                  hintText: 'Enter your name',
                  icon: Icons.person,
                  labelText: 'Full name',
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  labelText: 'Email address',
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  icon: Icons.lock,
                  obscureText: true,
                  labelText: 'Password',
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _handleSignUp,
                  child: const CustomButton(
                    text: 'Sign Up',
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Color(0xFF6156E2),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
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