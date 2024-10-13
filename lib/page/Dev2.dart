import 'package:flutter/material.dart';
import 'package:restaurant_3/database/database_helper.dart';
import 'package:restaurant_3/page/center_page.dart';

class Page2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100,
                foregroundImage: AssetImage('assets/images/Dev2.jpg'),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    'ชื่อ : อดิเทพ เกตุผล',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 20,
                        fontFamily: 'Kanit'),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    'Name : Adithep ketpol',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 20,
                        fontFamily: 'Kanit'),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    'เพศ : ชาย',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 20,
                        fontFamily: 'Kanit'),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    'Gender : Male',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 20,
                        fontFamily: 'Kanit'),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    'Tel : 088-738-3xxx',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 20,
                        fontFamily: 'Kanit'),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  title: Text(
                    'E-mail : Adithep.ke@ku.th',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 20,
                        fontFamily: 'Kanit'),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CenterPage(dbHelper: DatabaseHelper()))); // สร้าง CenterPage พร้อม DatabaseHelper
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
