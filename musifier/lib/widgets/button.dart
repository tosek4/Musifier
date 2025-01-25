import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 314, // Fixed width
      height: 60, // Fixed height
      child: ElevatedButton(
        onPressed: () {
          // Add your button logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6156E2), // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // Rounded corners
          ),
          elevation: 5, // Optional shadow effect
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, // Text color
            fontSize: 20, // Adjust font size as needed
            fontWeight: FontWeight.bold,// Optional bold text
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
