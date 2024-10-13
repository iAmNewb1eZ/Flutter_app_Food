import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import 'center_page.dart';
import '../database/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _passwd = '';

  Future _showAlert(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context); // showDialog() returns true
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 255, 253, 253),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add an image here
                Image.asset(
                  'assets/images/logo.jpg', //ใส่รูปตรงนี้
                  height: 300, // Adjust height as necessary
                  width: 300, // Adjust width as necessary
                ),
                const SizedBox(height: 20.0), // Space between image and title
                const SizedBox(
                  height: 100.0,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 45.0),
                TextFormField(
                  key: UniqueKey(),
                  obscureText: false,
                  initialValue: _email,
                  autofocus: true,
                  onChanged: (value) => _email = value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  key: UniqueKey(),
                  obscureText: true,
                  initialValue: _passwd,
                  onChanged: (value) => _passwd = value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                const SizedBox(height: 35.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.deepPurpleAccent,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      await UserAuthentication()
                          .signInWithEmailAndPassword(_email, _passwd)
                          .then((res) {
                        if (res == true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CenterPage(dbHelper: DatabaseHelper()),
                            ),
                          );
                          setState(() {
                            _email = '';
                            _passwd = '';
                          });
                        } else {
                          _showAlert(context, 'Invalid email or password for login');
                        }
                      });
                    },
                    child: const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}