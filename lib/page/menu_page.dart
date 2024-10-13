import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final List<String> menuNames = [
    'ออเดิร์ฟทะเล',
    'แป๊ะซะกุ้งชะอมไข่ทอด',
    'ห่อหมกทะเลมะพร้าวอ่อน',
    'ปลากระพงนึ่งมะนาว',
    'กุ้งเผา',
    'ขาหมูทอด',
    'กุ้งผัดเกลือกระทะร้อน',
    'ปลากระพงทรงเครื่อง',
    'กุ้งแช่น้ำปลา',
    'ปูผัดผงกระหรี่',
    'ปลาทับทิม 3 รส',
    'กบทอดกระเทียม',
    'แกงเผ็ดเป็ดย่าง',
    'ลาบปลาช่อนทอด',
    'สลัดกุ้งทอด',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายชื่อเมนู',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: const EdgeInsets.all(8.0),
        children: List.generate(menuNames.length, (index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  menuNames[index],
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
