import 'package:flutter/material.dart';
import 'package:musifier/pages/MusicPlayerPage.dart';
import 'package:musifier/pages/homePage.dart';
import 'package:musifier/pages/profilePage.dart';
import 'package:musifier/pages/searchSong.dart';

class NavigationWidget extends StatelessWidget {
  final int currentIndex;

  const NavigationWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
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
            context: context,
            index: 0,
            icon: Icons.home_outlined,
            isSelected: currentIndex == 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          _buildNavItem(
            context: context,
            index: 2,
            icon: Icons.search,
            isSelected: currentIndex == 2,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SongSearchPage()),
              );
            },
          ),
          _buildNavItem(
            context: context,
            index: 3,
            icon: Icons.person_outline,
            isSelected: currentIndex == 3,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }
}
