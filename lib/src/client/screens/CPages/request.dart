import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_1/src/client/screens/CPages/c_homescreen.dart'; // Import the home screen

class BookedServicesPage extends StatefulWidget {
  const BookedServicesPage({Key? key}) : super(key: key);

  @override
  State<BookedServicesPage> createState() => _BookedServicesPageState();
}

class _BookedServicesPageState extends State<BookedServicesPage> {
  int _selectedIndex = 1; // Set "My Bookings" as the default selected tab

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigate to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ClientHomePage()),
      );
    } else if (index == 1) {
      // Stay on "My Bookings"
    } else if (index == 2) {
      // Placeholder for Account page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account page is under construction.')),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings',style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('requests').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching requests.'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(
              child: Text(
                'No requests found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // Parse the data from Firebase
          Map<dynamic, dynamic> requests =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          // Convert the map to a list for display
          List<Map<String, dynamic>> requestList = requests.entries.map((entry) {
            return {
              'key': entry.key, // Store the unique key for updating the status
              'workerName': entry.value['workerName'],
              'workerSkill': entry.value['workerSkill'],
              'workerPhone': entry.value['workerPhone'], // Worker phone number
              'clientName': entry.value['clientName'],
              'clientContact': entry.value['clientContact'], // Client phone number
              'clientEmail': entry.value['clientEmail'], // Client email
              'timestamp': entry.value['timestamp'],
              'status': entry.value['status'] ?? 'Pending', // Default to "Pending"
            };
          }).toList();

          return ListView.builder(
            itemCount: requestList.length,
            itemBuilder: (context, index) {
              final request = requestList[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(request['workerName'] ?? 'Unknown Worker'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Skill: ${request['workerSkill'] ?? 'Unknown Skill'}'),
                      Text('Client: ${request['clientName'] ?? 'Unknown Client'}'),
                      Text('Worker Contact: ${request['workerPhone'] ?? 'Unknown Phone'}'), // Display worker phone
                      Text(
                        'Status: ${request['status']}',
                        style: TextStyle(
                          color: request['status'] == 'Accepted'
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _rejectRequest(context, request['key']);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Reject'),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _rejectRequest(BuildContext context, String requestKey) async {
    try {
      // Delete the request from Firebase
      await FirebaseDatabase.instance.ref('requests/$requestKey').remove();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request rejected.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error rejecting request: $e')),
      );
    }
  }
}