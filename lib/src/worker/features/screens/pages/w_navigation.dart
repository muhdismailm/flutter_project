import 'package:flutter/material.dart';
import 'package:login_1/src/worker/features/screens/login/w_logout.dart';
import 'package:login_1/src/worker/features/screens/pages/update_profile.dart'; // Import the profile update screen

class WorkerNavigationDrawer extends StatelessWidget {
  final String? userName;

  const WorkerNavigationDrawer({Key? key, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.amber),
                ),
                const SizedBox(height: 10),
                Text(
                  userName ?? 'User', // Display the logged-in user's name
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Worker',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.update, color: Colors.grey), // Explicitly set the icon color
            title: const Text('Update Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfile(), // Replace with your profile update screen
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined, color: Colors.grey), // Explicitly set the icon color
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WorkerLogoutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}