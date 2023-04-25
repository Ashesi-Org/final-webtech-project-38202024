import 'dart:convert';
import 'SignupPage.dart';
import 'LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset('home1.jpeg'),
          ),
          Positioned(
            top: 580,
            left: 532.5,
            right: 0,
            child: Row(
              children: [
                SizedBox(width: 100, height: 40), // add some spacing between the buttons & increase the height of the box
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent),
                  child: Text('Log In'),
                ),
                SizedBox(width: 90, height: 40), // add some spacing between the buttons & increase the height of the box
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





