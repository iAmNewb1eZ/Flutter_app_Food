import 'package:flutter/material.dart';
import 'package:restaurant_3/database/database_helper.dart';
import 'package:restaurant_3/page/Dev.dart';
import 'package:restaurant_3/page/history_page.dart';
import 'package:restaurant_3/page/drink_page.dart';
import 'package:restaurant_3/page/food_selector.dart';
import 'package:restaurant_3/page/orders_status.dart';
import 'package:restaurant_3/page/menu_page.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({super.key, required this.dbHelper});

  final DatabaseHelper dbHelper; // เก็บ dbHelper ใน widget

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList = [
      {'name': 'รายการอาหาร', 'icon': Icons.list_alt, 'page': FoodSelector()},
      {'name': 'เครื่องดื่ม', 'icon': Icons.local_drink, 'page': DrinkPage()},
      {
        'name': 'ประวัติการสั่ง',
        'icon': Icons.history,
        'page': OrderHistoryPage()
      },
      {
        'name': 'สถานะออเดอร์',
        'icon': Icons.fastfood_sharp,
        'page': OrderStatusPage()
      },
      {
        'name': 'เมนู',
        'icon': Icons.restaurant_menu_outlined,
        'page': MainMenu()
      },
      {'name': 'ติดต่อผู้พัฒนา', 'icon': Icons.person, 'page': Dev()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg3_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: dataList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => dataList[index]['page'])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.amber,
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(dataList[index]['icon'], size: 50),
                        const SizedBox(height: 10),
                        Text(
                          dataList[index]['name'],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
