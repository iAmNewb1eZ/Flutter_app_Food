import 'package:flutter/material.dart';
import 'Dev1.dart';
import 'Dev2.dart';

void main() {
  runApp(const Dev());
}

class Dev extends StatelessWidget {
  const Dev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devoloper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 214, 241, 10),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 214, 241, 10),

          /// TODO #1: scrollable is true
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.amber,
            indicatorWeight: 5,
            isScrollable: true,
            tabs: [
              Tab(text: 'Devoloper No.1', icon: Icon(Icons.person)),
              Tab(text: 'Devoloper No.2', icon: Icon(Icons.person_2_sharp)),
            ],
          ),
          title: const Text('Developer'),
        ),

        /// TODO #1: scrollable is true
        body: TabBarView(
          children: [
            Page1Screen(),
            Page2Screen(),
          ],
        ),
      ),
    );
  }
}
