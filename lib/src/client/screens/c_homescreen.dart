import 'package:flutter/material.dart';

class c_Homescreen extends StatefulWidget {
  const c_Homescreen({Key? key}) : super(key: key);

  @override
  _WHomescreenState createState() => _WHomescreenState();
}

class _WHomescreenState extends State<c_Homescreen> {
  // String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "WORKIFY",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Workify',
              style: TextStyle(fontSize: 16),
            ),            
          ],
        ),
      ),
    );
  }
}