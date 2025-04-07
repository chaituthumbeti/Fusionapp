import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final String role;
  NotificationProvider({required this.role});

  int selectedIndex = 1;
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> _allNotifications = [
    {
      "id": "notif1",
      "title": "Course Update",
      "desc": "The syllabus for Software Engineering has been revised.",
      "date": "13-02-2025",
      "isVisible": true,
      "read": false,
      "role": "student"
    },
    {
      "id": "notif2",
      "title": "Exam Reminder",
      "desc": "Mid-term exam schedule has been released.",
      "date": "12-02-2025",
      "isVisible": true,
      "read": false,
      "role": "student"
    },
    {
      "id": "notif3",
      "title": "New Assignment",
      "desc": "Assignment 3 has been uploaded to the portal.",
      "date": "11-02-2025",
      "isVisible": true,
      "read": false,
      "role": "student"
    },
    {
      "id": "notif4",
      "title": "Lecture Schedule",
      "desc": "Your lecture timings have been updated.",
      "date": "13-02-2025",
      "isVisible": true,
      "read": false,
      "role": "faculty"
    },
    {
      "id": "notif5",
      "title": "Student Query",
      "desc": "A student has sent a query regarding the assignment.",
      "date": "12-02-2025",
      "isVisible": true,
      "read": false,
      "role": "faculty"
    },
    {
      "id": "notif6",
      "title": "Research Update",
      "desc": "New research resources are available in the portal.",
      "date": "11-02-2025",
      "isVisible": true,
      "read": false,
      "role": "faculty"
    },
    {
      "id": "notif7",
      "title": "Faculty Update",
      "desc": "New faculty members have joined the department.",
      "date": "13-02-2025",
      "isVisible": true,
      "read": false,
      "role": "hod"
    },
    {
      "id": "notif8",
      "title": "Budget Report",
      "desc": "Monthly department budget report is ready.",
      "date": "12-02-2025",
      "isVisible": true,
      "read": false,
      "role": "hod"
    },
    {
      "id": "notif9",
      "title": "Accreditation Notice",
      "desc": "Accreditation visit scheduled next month.",
      "date": "11-02-2025",
      "isVisible": true,
      "read": false,
      "role": "hod"
    },
  ];

  final List<Map<String, dynamic>> _allAnnouncements = [
    {
      "id": "ann1",
      "title": "New Course Material",
      "desc": "Machine Learning resources have been uploaded.",
      "date": "10-02-2025",
      "isVisible": true,
      "read": false,
      "role": "student"
    },
    {
      "id": "ann2",
      "title": "Holiday Notice",
      "desc": "Campus will be closed on Friday for a public holiday.",
      "date": "08-02-2025",
      "isVisible": true,
      "read": false,
      "role": "student"
    },
    {
      "id": "ann3",
      "title": "Department Meeting",
      "desc": "Faculty meeting scheduled for next Monday.",
      "date": "10-02-2025",
      "isVisible": true,
      "read": false,
      "role": "faculty"
    },
    {
      "id": "ann4",
      "title": "Grant Application",
      "desc": "New grant application process announced.",
      "date": "08-02-2025",
      "isVisible": true,
      "read": false,
      "role": "faculty"
    },
    {
      "id": "ann5",
      "title": "Policy Update",
      "desc": "New guidelines for faculty evaluation have been released.",
      "date": "10-02-2025",
      "isVisible": true,
      "read": false,
      "role": "hod"
    },
    {
      "id": "ann6",
      "title": "Meeting Reminder",
      "desc": "Department meeting scheduled for this Friday.",
      "date": "08-02-2025",
      "isVisible": true,
      "read": false,
      "role": "hod"
    },
  ];

  // Lists to track recently opened items.
  List<Map<String, dynamic>> recent = [];
  Map<String, dynamic>? openedItem;

  // Getters that filter the master lists by the provider's role.
  List<Map<String, dynamic>> get notifications => _allNotifications
      .where((item) => item["role"] == role.toLowerCase() && item["isVisible"])
      .toList();

  List<Map<String, dynamic>> get announcements => _allAnnouncements
      .where((item) => item["role"] == role.toLowerCase() && item["isVisible"])
      .toList();

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
    final visibleItems = list.where((item) => item["isVisible"]).toList();
    if (index < visibleItems.length) {
      visibleItems[index]["isVisible"] = false;
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
