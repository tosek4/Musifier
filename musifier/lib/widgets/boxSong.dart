import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {
  final ImageProvider image;
  final String? text;

  const ContentBox({
    Key? key,
    required this.image,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (text != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
