import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();

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

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void scrollLeft() {
    scrollController.animateTo(
      scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void scrollRight() {
    scrollController.animateTo(
      scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void hideItem(int index) {
    final list = getCurrentList();
    final visible = list.where((item) => item["isVisible"]).toList();
    if (index < visible.length) {
      visible[index]["isVisible"] = false;
      notifyListeners();
    }
  }

  void openBigCard(Map<String, dynamic> item) {
    openedItem = item;

    if (!item["read"]) {
      item["read"] = true;
    }

    if (!recent.any((e) => e["id"] == item["id"])) {
      recent.insert(0, item);
      if (recent.length > 10) recent.removeLast();
    }

    notifyListeners();
  }

  void closeBigCard() {
    openedItem = null;
    notifyListeners();
  }

  List<Map<String, dynamic>> getCurrentList() {
    if (selectedIndex == 0) return recent;
    if (selectedIndex == 1) return notifications;
    return announcements;
  }

  int getUnreadCount(List<Map<String, dynamic>> list) {
    return list.where((item) => !item["read"] && item["isVisible"]).length;
  }
}
