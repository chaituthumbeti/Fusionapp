import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onClose;

  const MenuPage({super.key, required this.onClose});

  final List<Map<String, dynamic>> menuItems = const [
    {"title": "Academics", "icon": Icons.school, "subItems": ["Courses", "Grades"]},
    {"title": "Curriculum", "icon": Icons.book, "subItems": ["Subjects", "Electives"]},
    {"title": "Mess", "icon": Icons.restaurant, "subItems": ["Menu", "Timings"]},
    {"title": "Guest", "icon": Icons.person_add, "subItems": ["Request", "History"]},
    {"title": "Health", "icon": Icons.local_hospital, "subItems": ["Appointments", "Reports"]},
    {"title": "Scholarship", "icon": Icons.card_giftcard, "subItems": ["Apply", "Status"]},
    {"title": "Complaint", "icon": Icons.report_problem, "subItems": ["New", "Track"]},
    {"title": "Placement", "icon": Icons.work, "subItems": ["Opportunities", "Interviews"]},
  ];

  final List<Map<String, dynamic>> bottomItems = const [
    {"title": "Profile", "icon": Icons.person},
    {"title": "Settings", "icon": Icons.settings},
    {"title": "Help", "icon": Icons.help_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.75,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "MENU",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

                  ...menuItems.map((item) => _buildExpandableItem(
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
