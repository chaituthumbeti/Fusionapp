import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onClose;
  final String role;

  const MenuPage({super.key, required this.onClose, required this.role});

  final List<Map<String, dynamic>> menuItems = const [
    {
      "title": "Academics",
      "icon": Icons.school,
      "subItems": ["Courses", "Grades", "Manage Courses", "Student Grades"],
      "roles": ["student", "faculty", "admin"]
    },
    {
      "title": "Curriculum",
      "icon": Icons.book,
      "subItems": ["Subjects", "Electives", "Manage Subjects"],
      "roles": ["faculty", "admin"]
    },
    {
      "title": "Mess",
      "icon": Icons.restaurant,
      "subItems": ["Menu", "Timings", "Update Menu", "Schedule"],
      "roles": ["student", "admin"]
    },
    {
      "title": "Guest",
      "icon": Icons.person_add,
      "subItems": ["Request", "History", "Manage Requests", "Logs"],
      "roles": ["faculty", "admin"]
    },
    {
      "title": "Health",
      "icon": Icons.local_hospital,
      "subItems": ["Appointments", "Reports", "Health Records"],
      "roles": ["student", "admin"]
    },
    {
      "title": "Scholarship",
      "icon": Icons.card_giftcard,
      "subItems": ["Apply", "Status", "Applications"],
      "roles": ["student", "admin"]
    },
    {
      "title": "Complaint",
      "icon": Icons.report_problem,
      "subItems": ["New", "Track", "Manage", "Resolved", "All Complaints", "Analytics"],
      "roles": ["student", "faculty", "admin"]
    },
    {
      "title": "Placement",
      "icon": Icons.work,
      "subItems": ["Opportunities", "Interviews", "Manage Drives", "Results"],
      "roles": ["student", "admin"]
    },
  ];

  final List<Map<String, dynamic>> bottomItems = const [
    {"title": "Profile", "icon": Icons.person},
    {"title": "Settings", "icon": Icons.settings},
    {"title": "Help", "icon": Icons.help_outline},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMenuItems = menuItems
        .where((item) => (item["roles"] as List<String>).contains(role.toLowerCase()))
        .toList();

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MENU: $role",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ...filteredMenuItems.map((item) => _buildExpandableItem(
                        item["title"],
                        item["icon"],
                        item["subItems"],
                      )),
                  const Divider(thickness: 1.0, height: 32),
                  ...bottomItems.map((item) => _buildMenuItem(
                        item["title"],
                        item["icon"],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 24, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {},
    );
  }

  Widget _buildExpandableItem(String title, IconData icon, List<String> subItems) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        iconColor: Colors.blue,
        collapsedIconColor: Colors.blue,
        leading: Icon(icon, size: 24, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        children: subItems
            .map(
              (subItem) => Padding(
                padding: const EdgeInsets.only(left: 72, right: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    subItem,
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () {},
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
