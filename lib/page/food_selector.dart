import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../provider/store.dart';
import 'package:restaurant_3/database/database_helper.dart'; // Import DatabaseHelper
import 'package:restaurant_3/database/order.dart'; // Import Foods

class FoodSelector extends StatefulWidget {
  const FoodSelector({super.key});

  @override
  State<FoodSelector> createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> listFoods =
      []; // เปลี่ยนเป็น List<Map<String, dynamic>>
  List<Map<String, dynamic>> dropDownItems = [
    {
      'pic': '🍤🌊',
      'name': 'ออเดิร์ฟทะเล',
      'price': '250',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🍤🍳',
      'name': 'แป๊ะซะกุ้งชะอมไข่ทอด',
      'price': '220',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🥥🐚',
      'name': 'ห่อหมกทะเลมะพร้าวอ่อน',
      'price': '180',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🐟🍋',
      'name': 'ปลากระพงนึ่งมะนาว',
      'price': '300',
      'count': 1,
      'sum': 0
    },
    {'pic': '🍤🔥', 'name': 'กุ้งเผา', 'price': '350', 'count': 1, 'sum': 0},
    {'pic': '🐖🍖', 'name': 'ขาหมูทอด', 'price': '320', 'count': 1, 'sum': 0},
    {
      'pic': '🍤🔥🧂',
      'name': 'กุ้งผัดเกลือกระทะร้อน',
      'price': '240',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🐟🍛',
      'name': 'ปลากระพงทรงเครื่อง',
      'price': '250',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🍤🌊',
      'name': 'กุ้งแช่น้ำปลา',
      'price': '180',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🦀🌶️',
      'name': 'ปูผัดผงกระหรี่',
      'price': '450',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🐟🍲',
      'name': 'ปลาทับทิม 3 รส',
      'price': '300',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🐸🧄',
      'name': 'กบทอดกระเทียม',
      'price': '220',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🦆🍛',
      'name': 'แกงเผ็ดเป็ดย่าง',
      'price': '250',
      'count': 1,
      'sum': 0
    },
    {
      'pic': '🐟🌶️',
      'name': 'ลาบปลาช่อนทอด',
      'price': '200',
      'count': 1,
      'sum': 0
    },
    {'pic': '🥗🍤', 'name': 'สลัดกุ้งทอด', 'price': '210', 'count': 1, 'sum': 0}
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
    'ใส่กล่อง'
  ];

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();

    // คำนวณยอดรวม
    double totalSum = listFoods.fold(0, (sum, food) {
      return sum + double.parse(food['price']) * food['count'];
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าเลือกเมนู'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg3_1.jpg'), // ใช้ภาพพื้นหลัง
            fit: BoxFit.cover, // ทำให้ภาพเต็มพื้นที่
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'เลือกเมนู',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(width: 20),
                          DropdownButton(
                            hint: const Text(
                              'กดเลือกเมนู',
                              style: TextStyle(color: Colors.black),
                            ),
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
                            dropdownColor: Colors.orangeAccent,
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
                                size: 24, color: Colors.white),
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
                        dropdownColor: Colors.orangeAccent,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listFoods.length,
                  itemBuilder: (context, index) => Slidable(
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
                          label: 'ลบ',
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
              // ยอดรวมที่ด้านล่าง
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 232, 116, 7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ยอดรวม:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalSum.toStringAsFixed(2)} บาท',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Background color
                  onPrimary: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 12), // Button padding
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8)), // Rounded corners
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
                      const SnackBar(content: Text('สั่งอาหารเรียบร้อย!')),
                    );
                  });
                },
                child: const Text(
                  'ยืนยันการสั่งอาหาร',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget food({
    required List<dynamic> listFood,
    required int index,
    required provider,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading:
                  Text(listFood[index]['pic'], style: const TextStyle(fontSize: 30)),
              title: Text(listFood[index]['name']),
              subtitle: Text('${listFood[index]['price']} บาท'),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  provider.remove(listFood[index]);
                  setState(() {
                    listFood[index]['count'] = provider.count;
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Text(listFood[index]['count'].toString()),
              IconButton(
                onPressed: () {
                  provider.add(listFood[index]);
                  setState(() {
                    listFood[index]['count'] = provider.count;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
