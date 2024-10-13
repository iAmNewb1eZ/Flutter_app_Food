import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_3/database/database_helper.dart'; // Import DatabaseHelper
import 'package:restaurant_3/database/order.dart'; // Import Foods

class OrderHistoryPage extends StatelessWidget {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการสั่งอาหาร'),
        backgroundColor: Colors.deepPurple, // Customize AppBar color
      ),
      body: Container(
        color: Colors.grey[200], // Light background color for contrast
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
                final order = orders[index];
                final foods = List<Map<String, dynamic>>.from(order['foodItems']);
                final table = order['table'];
                final timestamp = DateTime.parse(order['timestamp']);

                // Format date and time
                final dateFormatted =
                    "${timestamp.day}/${timestamp.month}/${timestamp.year}";
                final timeFormatted =
                    "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} น.";

                return Dismissible(
                  key: Key(order.id), // Use order.id as unique key
                  direction: DismissDirection.endToStart, // Swipe from right to left only
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    // Delete order from Firestore
                    _dbHelper.deleteOrder(order.id);

                    // Show Snackbar notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ลบรายการอาหารจากโต๊ะ $table เรียบร้อย'),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4, // Elevation for shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Padding inside Card
                      child: ListTile(
                        title: Text(
                          ' $table',
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
                            ...foods.map((food) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '- ${food['name']} ราคา: ${food['price']} บาท',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )).toList(),
                          ],
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
