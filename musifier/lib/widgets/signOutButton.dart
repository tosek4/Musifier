import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignOutButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: const Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Icon(
            Icons.logout, 
            color: Color(0xFF6156E2),
            size: 20,
          ),
          SizedBox(width: 8), 
          Text(
            'Sign Out',
            style: TextStyle(
              color: Color(0xFF6156E2),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
