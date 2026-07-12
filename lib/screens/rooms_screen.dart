import 'package:flutter/material.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final List<Map<String, dynamic>> _rooms = [
    {
      'name': 'Mathematics Study Room',
      'members': 12,
      'topic': 'Calculus - Chapter 5',
      'active': true,
    },
    {
      'name': 'Physics Discussion',
      'members': 8,
      'topic': 'Quantum Mechanics',
      'active': true,
    },
    {
      'name': 'Literature Review',
      'members': 5,
      'topic': 'Shakespeare\'s Works',
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.meeting_room, color: Colors.blue),
              ),
              title: Text(
                room['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(room['topic']),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        room['active'] ? Icons.circle : Icons.circle_outlined,
                        size: 12,
                        color: room['active'] ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        room['active'] ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 12,
                          color: room['active'] ? Colors.green : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.people, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${room['members']} members',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Join'),
              ),
              onTap: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
