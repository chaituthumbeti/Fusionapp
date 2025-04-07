import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ModulePage extends StatelessWidget {
  final String role;

  const ModulePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> studentModules = [
      {'icon': HugeIcons.strokeRoundedTeacher, 'label': 'Academics'},
      {'icon': HugeIcons.strokeRoundedCalendar03, 'label': 'Timetable'},
      {'icon': Icons.fastfood, 'label': 'Mess Menu'},
      {'icon': Icons.health_and_safety, 'label': 'Health Services'},
      {'icon': Icons.apartment, 'label': 'Hostel Info'},
      {'icon': Icons.mail_outline, 'label': 'Complaints'},
    ];

    final List<Map<String, dynamic>> hodModules = [
      {'icon': HugeIcons.strokeRoundedTeacher, 'label': 'Faculty Management'},
      {'icon': HugeIcons.strokeRoundedCalendar03, 'label': 'Department Schedule'},
      {'icon': Icons.analytics, 'label': 'Reports'},
      {'icon': Icons.supervised_user_circle, 'label': 'Student Progress'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    final List<Map<String, dynamic>> facultyModules = [
      {'icon': HugeIcons.strokeRoundedTeacher, 'label': 'My Courses'},
      {'icon': HugeIcons.strokeRoundedCalendar03, 'label': 'Class Schedule'},
      {'icon': Icons.grade, 'label': 'Marks Entry'},
      {'icon': Icons.event_note, 'label': 'Attendance'},
      {'icon': Icons.mail, 'label': 'Student Queries'},
    ];

    final List<Map<String, dynamic>> modules;
    switch (role.toLowerCase()) {
      case 'hod':
        modules = hodModules;
        break;
      case 'faculty':
        modules = facultyModules;
        break;
      case 'student':
      default:
        modules = studentModules;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search, color: Colors.black),
                    hintText: "$role modules",
                    hintStyle: const TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: modules.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    final item = modules[index];
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
