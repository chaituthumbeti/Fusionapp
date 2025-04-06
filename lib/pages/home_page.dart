import 'package:flutter/material.dart';
import 'widgets/notification_card.dart';
import 'widgets/detail.dart';
import 'package:hugeicons/hugeicons.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> categories = ['Recent', 'Notifications', 'Announcements'];
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> notifications = [
    {
      "id": "notif1",
      "title": "Course Update",
      "desc": "The Syllabus for Software Engineering has been revised.",
      "date": "13-02-2025",
      "isVisible": true,
      "read": false,
    },
    {
      "id": "notif2",
      "title": "Course Update",
      "desc": "The Syllabus for Computer Networks has been updated.",
      "date": "12-02-2025",
      "isVisible": true,
      "read": false,
    },
    {
      "id": "notif3",
      "title": "Course Update",
      "desc": "The AI syllabus has been improved.",
      "date": "11-02-2025",
      "isVisible": true,
      "read": false,
    },
  ];

  List<Map<String, dynamic>> announcements = [
    {
      "id": "ann1",
      "title": "New Course Material",
      "desc": "Machine Learning resources uploaded to portal.",
      "date": "10-02-2025",
      "isVisible": true,
      "read": false,
    },
    {
      "id": "ann2",
      "title": "Exam Schedule Update",
      "desc": "Mid-term exams rescheduled due to syllabus changes.",
      "date": "08-02-2025",
      "isVisible": true,
      "read": false,
    },
  ];

  List<Map<String, dynamic>> recent = [];
  Map<String, dynamic>? openedItem;

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void hideItem(int index) {
    setState(() {
      var currentList = selectedIndex == 1 ? notifications : announcements;
      var visibleItems =
          currentList.where((item) => item["isVisible"]).toList();
      if (index < visibleItems.length) {
        var itemToHide = visibleItems[index];
        itemToHide["isVisible"] = false;
      }
    });
  }

  void openBigCard(Map<String, dynamic> item) {
    setState(() {
      openedItem = item;

      if (!item["read"]) {
        item["read"] = true;
      }

      if (!recent.any((e) => e["id"] == item["id"])) {
        recent.insert(0, item);

        if (recent.length > 10) {
          recent.removeLast();
        }
      }
    });
  }

  void closeBigCard() {
    setState(() {
      openedItem = null;
    });
  }

  int getUnreadCount(List<Map<String, dynamic>> list) {
    return list.where((item) => !item["read"] && item["isVisible"]).length;
  }

  Widget _buildBadge(int count) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentList =
        selectedIndex == 0
            ? recent
            : selectedIndex == 1
            ? notifications
            : announcements;

    int unreadNotifications = getUnreadCount(notifications);
    int unreadAnnouncements = getUnreadCount(announcements);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Home > ${categories[selectedIndex]}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: scrollLeft,
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap:
                                  () => setState(() => selectedIndex = index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      selectedIndex == index
                                          ? Colors.lightBlue.shade100
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      categories[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            selectedIndex == index
                                                ? Colors.blue
                                                : Colors.black,
                                      ),
                                    ),
                                    if (index == 1 && unreadNotifications > 0)
                                      _buildBadge(unreadNotifications),
                                    if (index == 2 && unreadAnnouncements > 0)
                                      _buildBadge(unreadAnnouncements),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: scrollRight,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      Expanded(
                        child: Divider(color: Colors.black, thickness: 2),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 4),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        HugeIcons.strokeRoundedFilter,
                        color: Colors.black,
                        size: 16,
                      ), 
                      label: const Text(
                        'Sort By',
                        style: TextStyle(
                          fontSize: 12, 
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade100,
                        side: const BorderSide(color: Colors.blue, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: const Size(0, 20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        currentList.where((item) => item["isVisible"]).length,
                    itemBuilder: (context, index) {
                      final visibleItems =
                          currentList
                              .where((item) => item["isVisible"])
                              .toList();
                      final item = visibleItems[index];

                      return NotificationCard(
                        item: item,
                        onTap: () => openBigCard(item),
                        onDelete: () => hideItem(index),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (openedItem != null)
              ItemDetailModal(item: openedItem!, onClose: closeBigCard),
          ],
        ),
      ),
    );
  }
}
