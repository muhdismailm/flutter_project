import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkerLogoutPage extends StatelessWidget {
  const WorkerLogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut(); // Sign out the user
                    Navigator.of(context).pushReplacementNamed('/login'); // Navigate to the login screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button background color
                    foregroundColor: Colors.white, // Button text color
                  ),
                  child: const Text('Logout'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the logout page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Button background color
                    foregroundColor: Colors.white, // Button text color
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
