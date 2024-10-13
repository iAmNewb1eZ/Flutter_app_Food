import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../provider/store.dart';
import 'package:restaurant_3/database/database_helper.dart'; // Import DatabaseHelper
import 'package:restaurant_3/database/order.dart'; // Import Foods

class DrinkPage extends StatefulWidget {
  const DrinkPage({super.key});

  @override
  State<DrinkPage> createState() => _DrinkPage();
}

class _DrinkPage extends State<DrinkPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> listFoods = [];

  List<Map<String, dynamic>> dropDownItems = [
    {'pic': '💧', 'name': 'น้ำเปล่า', 'price': '10', 'count': 1, 'sum': 0},
    {'pic': '🥤', 'name': 'โค๊กแก้วโอ้ง', 'price': '25', 'count': 1, 'sum': 0},
    {'pic': '🧋', 'name': 'ชานมเย็น', 'price': '30', 'count': 1, 'sum': 0},
    {'pic': '🍫', 'name': 'โกโก้', 'price': '30', 'count': 1, 'sum': 0},
    {'pic': '🍵', 'name': 'ชาเขียว', 'price': '30', 'count': 1, 'sum': 0},
    {'pic': '🌼', 'name': 'เก็กฮวย', 'price': '20', 'count': 1, 'sum': 0},
    {'pic': '🍋', 'name': 'ชามะนาว', 'price': '20', 'count': 1, 'sum': 0},
    {'pic': '🍈', 'name': 'กระเจียบ', 'price': '20', 'count': 1, 'sum': 0},
    {'pic': '🍹', 'name': 'แดงมะนาวโซดา', 'price': '30', 'count': 1, 'sum': 0},
    {'pic': '🌊', 'name': 'บลูฮาวาย', 'price': '30', 'count': 1, 'sum': 0},
  ];

  String? dropDown;
  String? itemTable = 'โต๊ะ1';
  List<String> itemsTable = [
    'โต๊ะ1',
    'โต๊ะ2',
    'โต๊ะ3',
    'โต๊ะ4',
    'โต๊ะ5',
    'โต๊ะ6',
  ];

  double calculateTotal() {
    double total = 0;
    for (var food in listFoods) {
      total += int.parse(food['price']) * food['count'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าเลือกเครื่องดื่ม'),
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // ภาพพื้นหลัง
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/bg3_1.jpg'), // เพิ่มภาพพื้นหลัง (เปลี่ยนตาม path ของไฟล์)
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // เนื้อหา
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Dropdown และปุ่มเลือกเครื่องดื่ม
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green[50]?.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'เลือกเครื่องดื่ม',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20),
                          DropdownButton(
                            hint: const Text('กดเลือกเครื่องดื่ม'),
                            value: dropDown,
                            items: dropDownItems.map((item) {
                              return DropdownMenuItem(
                                value: item['name'],
                                child: Text(item['name']),
                              );
                            }).toList(),
                            onChanged: (item) {
                              setState(() {
                                dropDown = item.toString();
                              });
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                var selectedFood = dropDownItems
                                    .firstWhere((e) => e['name'] == dropDown);
                                if (!listFoods.any(
                                    (e) => e['name'] == selectedFood['name'])) {
                                  listFoods.add(selectedFood);
                                }
                              });
                            },
                            icon: const Icon(Icons.add,
                                size: 24, color: Colors.green),
                          ),
                        ],
                      ),
                      DropdownButton(
                        value: itemTable,
                        items: itemsTable.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            itemTable = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // ListView แสดงรายการเครื่องดื่มที่เลือก
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: listFoods.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                setState(() {
                                  listFoods.removeAt(index);
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: food(
                          listFood: listFoods,
                          index: index,
                          provider: provider,
                        ),
                      ),
                    ),
                  ),
                ),
                // แสดงยอดรวมและปุ่มยืนยัน
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green[50]?.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ยอดรวม: ${calculateTotal()} บาท',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          textStyle: const TextStyle(fontSize: 24),
                          backgroundColor: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Foods order = Foods(
                            table: itemTable!,
                            foodItems: listFoods,
                            timestamp: DateTime.now(),
                          );

                          // เพิ่มข้อมูลลง Firebase
                          _dbHelper.insertOrder(order).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('สั่งอาหารเรียบร้อย!')),
                            );
                          });
                        },
                        child: const Text(
                          'ยืนยันการสั่งอาหาร',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget food({
    required List<dynamic> listFood,
    required int index,
    required provider,
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Text(
        listFood[index]['pic'],
        style: const TextStyle(fontSize: 30),
      ),
      title: Text(
        listFood[index]['name'],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${listFood[index]['price']} บาท'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              provider.remove(listFood[index]);
              setState(() {
                listFood[index]['count'] = provider.count;
              });
            },
            icon: const Icon(Icons.remove, color: Colors.red),
          ),
          Text(listFood[index]['count'].toString()),
          IconButton(
            onPressed: () {
              provider.add(listFood[index]);
              setState(() {
                listFood[index]['count'] = provider.count;
              });
            },
            icon: const Icon(Icons.add, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
