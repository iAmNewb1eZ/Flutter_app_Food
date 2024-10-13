import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_3/database/database_helper.dart'; // Import DatabaseHelper
import 'package:restaurant_3/database/order.dart'; // Import Foods

class OrderStatusPage extends StatelessWidget {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สถานะการสั่งอาหาร'),
        backgroundColor: Colors.deepPurple, // Customize AppBar color
      ),
      body: Container(
        color: Colors.grey[200], // Light background color
        child: StreamBuilder<QuerySnapshot>(
          stream: _dbHelper.getOrderStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final orders = snapshot.data!.docs;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index].data() as Map<String, dynamic>; // Convert DocumentSnapshot to Map

                final foods = order.containsKey('foodItems')
                    ? List<Map<String, dynamic>>.from(order['foodItems'])
                    : [];
                final table =
                    order.containsKey('table') ? order['table'] : 'โต๊ะไม่ระบุ';
                final isCompleted = order.containsKey('isCompleted')
                    ? order['isCompleted']
                    : false;

                // Check if timestamp is Timestamp or String
                DateTime timestamp;
                if (order.containsKey('timestamp')) {
                  if (order['timestamp'] is Timestamp) {
                    timestamp = (order['timestamp'] as Timestamp).toDate();
                  } else if (order['timestamp'] is String) {
                    timestamp = DateTime.parse(order['timestamp']);
                  } else {
                    timestamp = DateTime.now(); // Use current date if timestamp is missing
                  }
                } else {
                  timestamp = DateTime.now(); // Use current date if field is missing
                }

                // Format date and time
                final dateFormatted =
                    "${timestamp.day}/${timestamp.month}/${timestamp.year}";
                final timeFormatted =
                    "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} น.";

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4, // Elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: ListTile(
                    title: Text(
                      '$table',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.deepPurple, // Title color
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลา: $timeFormatted วันที่: $dateFormatted',
                          style: TextStyle(
                            color: Colors.grey[600], // Subtitle color
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8), // Spacing between time and food items
                        for (var food in foods)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              '- ${food['name']} ราคา: ${food['price']} บาท',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Toggle order status when button is pressed
                        _dbHelper.updateOrderStatus(
                            orders[index].id, !isCompleted);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: isCompleted ? Colors.green : Colors.orange, // Color based on status
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Rounded button corners
                        ),
                      ),
                      child: Text(
                        isCompleted ? 'เสริฟแล้ว' : 'ยังไม่เสริฟ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
