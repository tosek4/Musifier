import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musifier/pages/loginPage.dart';
import '../widgets/button.dart';
import '../widgets/textInput.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';
  String _successMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    setState(() {
      _errorMessage = '';
      _successMessage = '';
    });

    if (_emailController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email';
      });
      return;
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      setState(() {
        _successMessage = 'A password reset link has been sent to your email.';
      });

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Color(0xFF1B1B37),
      ),
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
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                  ),
                ),
                const SizedBox(height: 60),
                CustomInputField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                  obscureText: false,
                  labelText: 'Email',
                ),
                const SizedBox(height: 16),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: 'Nunito-Regular',
                    ),
                  ),
                if (_successMessage.isNotEmpty)
                  Text(
                    _successMessage,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontFamily: 'Nunito-Regular',
                    ),
                  ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _resetPassword,
                  child: CustomButton(
                    text: 'Reset Password',
                    onPressed: _resetPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
