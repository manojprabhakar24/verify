import 'package:flutter/material.dart';
import 'package:verify/screens/welcome_screen.dart';

class MainScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const MainScreen({Key? key, required this.name, required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(), // Replace with your authentication screen widget
                  ),
                      (route) => false,
                );
              },
            ),
            Text(
              'Name :  $name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone Number :  $phoneNumber',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add your main screen content here
          ],
        ),
      ),
    );
  }
}
