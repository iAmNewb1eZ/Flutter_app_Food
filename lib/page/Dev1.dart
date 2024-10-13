import 'package:flutter/material.dart';
import 'package:restaurant_3/database/database_helper.dart'; // เพิ่มการนำเข้า DatabaseHelper
import 'center_page.dart';

class Page1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Kanit'),
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center, // จัดแนวกลาง
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Dev1.jpg'),
                radius: 120,
              ),
              const SizedBox(height: 10), // เพิ่มระยะห่าง
              const ListTile(
                title: Text(
                  'ชนกานต์ ศรีเหรา',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.yellowAccent,
                ),
              ),
              const ListTile(
                title: Text(
                  'Chonnakan Srihera',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
                ),
                leading: Icon(
                  Icons.person_2,
                  color: Colors.yellowAccent,
                ),
              ),
              const ListTile(
                title: Text(
                  'เพศ : ชาย',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
                ),
                leading: Icon(
                  Icons.man,
                  color: Colors.yellowAccent,
                ),
              ),
              const ListTile(
                title: Text(
                  'Tel : 09x-xxx-xxxx',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
                ),
                leading: Icon(
                  Icons.phone,
                  color: Colors.yellowAccent,
                ),
              ),
              const ListTile(
                title: Text(
                  'E-mail : Chanakarn.srih@ku.th',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
                ),
                leading: Icon(
                  Icons.email,
                  color: Colors.yellowAccent,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CenterPage(dbHelper: DatabaseHelper())), // ส่งผ่าน DatabaseHelper
                  );
                },
                child: const Text('Go to Main Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
