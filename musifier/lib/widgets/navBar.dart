import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  final int currentIndex;

  const NavigationWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 85,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B37),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.20),
            offset: const Offset(0, -3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            index: 0,
            icon: Icons.home_outlined,
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            index: 1,
            icon: Icons.music_note_outlined,
            isSelected: currentIndex == 1,
          ),
          _buildNavItem(
            index: 2,
            icon: Icons.search,
            isSelected: currentIndex == 2,
          ),
          _buildNavItem(
            index: 3,
            icon: Icons.person_outline,
            isSelected: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required bool isSelected,
  }) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF6156E2) : Colors.white54,
              size: 34,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}