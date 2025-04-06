import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ModulePage extends StatelessWidget {
  ModulePage ({super.key});
  final List<Map<String, dynamic>> features = [
    {'icon': HugeIcons.strokeRoundedTeacher, 'label': 'Academics'},
    {'icon': HugeIcons.strokeRoundedCalendar03, 'label': 'Curriculum'},
    {'icon': HugeIcons.strokeRoundedRestaurant01, 'label': 'Mess'},
    {'icon': Icons.health_and_safety, 'label': 'Health'},
    {'icon': Icons.apartment, 'label': 'Hostel'},
    {'icon': Icons.mail_outline, 'label': 'Complaint'},
    {'icon': Icons.menu_book, 'label': 'Academics'},
    {'icon': Icons.calendar_today, 'label': 'Curriculum'},
    {'icon': Icons.restaurant, 'label': 'Mess'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.black),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔲 Grid Buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: features.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    final item = features[index];
                    return FeatureButton(
                      icon: item['icon'],
                      label: item['label'],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.black),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
