import 'package:flutter/material.dart';

class ProgramDetailScreen extends StatelessWidget {
  final Map<String, dynamic> programData;

  const ProgramDetailScreen({super.key, required this.programData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(programData['title'] ?? 'Program Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(programData['imageUrl'] ?? '', height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('Trainer: ${programData['trainer']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Difficulty: ${programData['difficulty']}'),
            Text('Duration: ${programData['duration']}'),
            Text('Goal: ${programData['goal']}'),
            Text('Price: ₹${programData['price']}'),
            const SizedBox(height: 20),
            const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(programData['description'] ?? 'No description provided.',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}