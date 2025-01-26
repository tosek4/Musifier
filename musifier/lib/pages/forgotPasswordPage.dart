import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/textInput.dart';
import 'loginPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSavePassword() {
    setState(() {

      _errorMessage = '';


      if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
        _errorMessage = 'Please fill in both password fields';
      }

      else if (_newPasswordController.text != _confirmPasswordController.text) {
        _errorMessage = 'Passwords do not match';
      }

      else {
        print('Password changed successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
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
                  'Forgot \nPassword',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                  ),
                ),
                const SizedBox(height: 60),
                CustomInputField(
                  controller: _newPasswordController,
                  hintText: 'Enter new password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  labelText: 'New Password',
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm new password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  labelText: 'Confirm Password',
                ),
                const SizedBox(height: 10),

                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: 'Nunito-Regular',
                    ),
                  ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _handleSavePassword,
                  child: CustomButton(
                    text: 'Save',
                    onPressed: _handleSavePassword,
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
