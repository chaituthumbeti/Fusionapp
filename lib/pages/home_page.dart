import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/notification_card.dart';
import 'widgets/detail.dart';
import 'package:hugeicons/hugeicons.dart';
import 'widgets/notification_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);

    final categories = ['Recent', 'Notifications', 'Announcements'];
    final currentList = provider.getCurrentList();

    final unreadNotifications = provider.getUnreadCount(provider.notifications);
    final unreadAnnouncements = provider.getUnreadCount(provider.announcements);

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
                    'Home > ${categories[provider.selectedIndex]}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: provider.scrollLeft,
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: provider.scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => provider.setSelectedIndex(index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: provider.selectedIndex == index
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
                                        color: provider.selectedIndex == index
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
                        onPressed: provider.scrollRight,
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
                      icon: const Icon(
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
                          currentList.where((item) => item["isVisible"]).toList();
                      final item = visibleItems[index];

                      return NotificationCard(
                        item: item,
                        onTap: () => provider.openBigCard(item),
                        onDelete: () => provider.hideItem(index),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (provider.openedItem != null)
              ItemDetailModal(
                item: provider.openedItem!,
                onClose: provider.closeBigCard,
              ),
          ],
        ),
      ),
    );
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
}