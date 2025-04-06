import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          if (selectedIndex >= 0 && selectedIndex < 4)
            Positioned(
              top: -15,
              left: MediaQuery.of(context).size.width / 4 * selectedIndex +
                  (MediaQuery.of(context).size.width / 8) -
                  30,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  _getIcon(selectedIndex),
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, HugeIcons.strokeRoundedHome12),
                _buildNavItem(1, HugeIcons.strokeRoundedComputer),
                _buildNavItem(2, HugeIcons.strokeRoundedUser),
                _buildNavItem(3, HugeIcons.strokeRoundedLogout04),
              ],
            ),
          ),
          if (selectedIndex >= 0 && selectedIndex < 4)
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width / 4 * selectedIndex +
                  (MediaQuery.of(context).size.width / 16),
              child: Container(
                width: MediaQuery.of(context).size.width / 8,
                height: 3,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
        child: isSelected
            ? const SizedBox()
            : Icon(
                icon,
                color: Colors.white,
                size: 35,
              ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return HugeIcons.strokeRoundedHome12;
      case 1:
        return HugeIcons.strokeRoundedComputer;
      case 2:
        return HugeIcons.strokeRoundedUser;
      case 3:
        return HugeIcons.strokeRoundedLogout04;
      default:
        return HugeIcons.strokeRoundedHome12;
    }
  }
}
