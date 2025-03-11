import 'package:flutter/material.dart';
import 'package:login_1/src/client/widgets/custom_appbar.dart';

class CHomescreen extends StatefulWidget {
  const CHomescreen({Key? key}) : super(key: key);

  @override
  _CHomescreenState createState() => _CHomescreenState();
}

class _CHomescreenState extends State<CHomescreen> {
  // String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'), // Use the custom AppBar with title
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