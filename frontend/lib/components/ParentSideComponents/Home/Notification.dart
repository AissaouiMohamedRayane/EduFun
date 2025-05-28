import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'remove already completed chapter 3',
      category: 'train up',
      icon: 'assets/fonts/G.png',
    ),
    NotificationItem(
      title: 'throw two o ghdi mouds in quick H X X',
      category: 'hugs',
      icon: 'assets/fonts/S.png',
    ),
    NotificationItem(
      title: 'throw two o ghdi mouds in quick H X X',
      category: 'start-up',
      icon: 'assets/fonts/B.png',
    ),
    NotificationItem(
      title: 'throw two o ghdi mouds in quick H X X',
      category: 'running',
      icon: 'assets/fonts/G.png',
    ),
    NotificationItem(
      title: 'throw two o ghdi mouds in quick H X X',
      category: 'hugs',
      icon: 'assets/fonts/S.png',
    ),
    NotificationItem(
      title: 'throw two o ghdi mouds in quick H X X',
      category: 'hugs',
      icon: 'assets/fonts/B.png',
    ),
    NotificationItem(
      title: 'throw two o ghdi mouds in quick H X X',
      category: 'running up',
      icon: 'assets/fonts/G.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(215, 241, 237, 1),
      appBar: AppBar(
        title: Container(
          child: Text(
            'Notifications',

            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(
            title: notification.title,
            category: notification.category,
            iconPath: notification.icon,
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String category;
  final String icon;

  NotificationItem({
    required this.title,
    required this.category,
    required this.icon,
  });
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String category;
  final String iconPath;

  const NotificationCard({
    required this.title,
    required this.category,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(172, 236, 227, 1),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon from assets
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
              errorBuilder:
                  (context, error, stackTrace) => Icon(Icons.notifications),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification title
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  // Category with colored chip
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'hugs':
        return Colors.blue;
      case 'train up':
        return Colors.green;
      case 'start-up':
        return Colors.orange;
      case 'running':
      case 'running up':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
