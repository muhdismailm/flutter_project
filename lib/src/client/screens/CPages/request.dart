import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BookedServicesPage extends StatelessWidget {
  const BookedServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Requests'),
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
              'clientName': entry.value['clientName'],
              'clientContact': entry.value['clientContact'],
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
                      Text('Contact: ${request['clientContact'] ?? 'Unknown Contact'}'),
                      Text(
                        'Status: ${request['status']}', // Display the status
                        style: TextStyle(
                          color: request['status'] == 'Accepted'
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}