import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_1/src/worker/features/screens/pages/HomeScreen.dart';
import 'package:login_1/src/worker/features/screens/pages/w_navigation.dart' hide HomePage;

class WorkerRequestsPage extends StatefulWidget {
  const WorkerRequestsPage({Key? key}) : super(key: key);

  @override
  State<WorkerRequestsPage> createState() => _WorkerRequestsPageState();
}

class _WorkerRequestsPageState extends State<WorkerRequestsPage> {
  int _selectedIndex = 1; // Set "Requests" as the default selected tab

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigate to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      // Stay on "Requests"
    } else if (index == 2) {
      // Navigate to Account
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerNavigationDrawer()),
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
        title: const Text('Client Requests'),
        backgroundColor: Colors.amber,
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
              'key': entry.key, // Store the unique key for deletion
              'workerName': entry.value['workerName'],
              'workerSkill': entry.value['workerSkill'],
              'clientName': entry.value['clientName'],
              'clientPhone': entry.value['clientPhone'], // Use clientPhone instead of clientContact
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
                  leading: const Icon(Icons.person, color: Colors.amber),
                  title: Text(request['clientName'] ?? 'Unknown Client'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Skill: ${request['workerSkill'] ?? 'Unknown Skill'}'),
                      Text('Contact: ${request['clientPhone'] ?? 'Unknown Phone'}'), // Updated field
                      Text('Timestamp: ${request['timestamp'] ?? 'Unknown Time'}'),
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
                      _showRequestDetailsDialog(context, request);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('View'),
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
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }

  void _showRequestDetailsDialog(BuildContext context, Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Client Details: ${request['clientName']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Skill: ${request['workerSkill']}'),
              const SizedBox(height: 8),
              Text('Contact: ${request['clientPhone']}'), // Updated field
              const SizedBox(height: 8),
              Text('Timestamp: ${request['timestamp']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Reject the request (delete from Firebase)
                await FirebaseDatabase.instance
                    .ref('requests/${request['key']}')
                    .remove();
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request rejected.')),
                );
              },
              child: const Text('Reject', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                _acceptRequest(request['key']);
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request accepted.')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  void _acceptRequest(String requestKey) async {
    try {
      // Update the status to "Accepted" in Firebase
      await FirebaseDatabase.instance
          .ref('requests/$requestKey')
          .update({'status': 'Accepted'});
    } catch (e) {
      print('Error accepting request: $e');
    }
  }
}