import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final VoidCallback onMenuPressed; 
  final ValueChanged<String> roleChange;

  const TopNavBar({
    super.key,
    required this.selectedIndex,
    required this.onMenuPressed,
    required this.roleChange,
  });

  @override
  State<TopNavBar> createState() => _TopNavBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(100);
  }
}

class _TopNavBarState extends State<TopNavBar> {
  final List<String> _titles = ["Dashboard", "Modules", "Profile", "Logout", "Menu"];
  String _selectedRole = 'Student';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double navbarHeight = screenHeight * 0.15;

    return SizedBox(
      height: navbarHeight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.school, size: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedRole,
                              icon: const Icon(Icons.arrow_drop_down, size: 14, color: Colors.black),
                              items: ['Student', 'Faculty', 'Hod'].map((String role) {
                                return DropdownMenuItem<String>(
                                  value: role,
                                  child: Text(role, style: const TextStyle(fontSize: 12)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedRole = newValue;
                                    widget.roleChange(newValue);
                                  });
                                }
                              },
                              underline: const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Chaitanya',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '22BCS253',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _titles[widget.selectedIndex],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 28,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onPressed: widget.onMenuPressed,
                          icon: const Icon(HugeIcons.strokeRoundedMenu01, size: 14, color: Colors.white),
                          label: const Text(
                            'Menu',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
