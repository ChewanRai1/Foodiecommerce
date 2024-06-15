import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Notification App',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         fontFamily: 'Montserrat', // Custom font
//       ),
//       home: NotificationView(),
//     );
//   }
// }

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<NotificationData> notifications = [
    NotificationData(
        image: 'assets/notification1.jpg',
        message: 'Dear customer, your delivery arrived at 11PM',
        time: '5 minutes ago'),
    NotificationData(
        image: 'assets/notification2.jpg',
        message: 'Dear customer, your delivery arrived at 11PM',
        time: '1 hour ago'),
    NotificationData(
        image: 'assets/notification3.jpg',
        message: 'Dear customer, your delivery arrived at 11PM',
        time: '2 hours ago'),
    NotificationData(
        image: 'assets/notification4.jpg',
        message: 'Dear customer, your delivery arrived at 11PM',
        time: '23 hours ago'),
    NotificationData(
        image: 'assets/notification5.jpg',
        message: 'Dear customer, your delivery arrived at 11PM',
        time: '1 day ago'),
  ];

  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = List<bool>.generate(notifications.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.select_all),
            onPressed: selectAllNotifications,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(notifications[index].image),
                    ),
                    title: Text(
                      notifications[index].message,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selectedItems[index] ? Colors.red : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      notifications[index].time,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedItems[index] = !selectedItems[index];
                      });
                    },
                    selected: selectedItems[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: deleteSelectedNotifications,
            child: Text(
              'Delete Selected',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: deleteAllNotifications,
            child: Text(
              'Delete All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void selectAllNotifications() {
    setState(() {
      bool allSelected = selectedItems.every((element) => element);
      if (allSelected) {
        selectedItems =
            List<bool>.generate(notifications.length, (index) => false);
      } else {
        selectedItems =
            List<bool>.generate(notifications.length, (index) => true);
      }
    });
  }

  void deleteSelectedNotifications() {
    setState(() {
      List<NotificationData> temp = [];
      for (int i = 0; i < selectedItems.length; i++) {
        if (!selectedItems[i]) {
          temp.add(notifications[i]);
        }
      }
      notifications = List.from(temp);
      selectedItems =
          List<bool>.generate(notifications.length, (index) => false);
    });
  }

  void deleteAllNotifications() {
    setState(() {
      notifications.clear();
      selectedItems.clear();
    });
  }
}

class NotificationData {
  final String image;
  final String message;
  final String time;

  NotificationData(
      {required this.image, required this.message, required this.time});
}
