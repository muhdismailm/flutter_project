import 'package:flutter/material.dart';
import 'package:login_1/src/worker/features/screens/widgets/w_appbar.dart';

class W_Homescreen extends StatefulWidget {
  const W_Homescreen({Key? key}) : super(key: key);

  @override
  _WHomescreenState createState() => _WHomescreenState();
}

class _WHomescreenState extends State<W_Homescreen> {
  // String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const WAppbar(title: 'Home'),
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