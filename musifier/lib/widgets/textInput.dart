import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String labelText;
  final Widget? trailing;

  const CustomInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    required this.labelText,
    this.trailing,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.labelText,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito-Regular',
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: 5),
              widget.trailing!,
            ],
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C4E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito-Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                    suffixIcon: widget.obscureText
                        ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF6156E2),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                        : null,
                  ),
                  cursorColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
