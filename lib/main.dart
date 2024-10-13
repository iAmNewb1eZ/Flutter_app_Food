import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_3/provider/store.dart';
import 'page/center_page.dart';
import 'page/food_selector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'page/login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAegVTX0xJlwaG-pkB7ofdUBsvN3bo_tw0",
      appId: "1:61556895724:android:8802032201a1f94649dac9",
      messagingSenderId: "",
      projectId: "flutter-educate-c6765",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Store(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(126, 191, 186, 186),
        ),
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
