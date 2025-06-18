import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // You can replace these with Firebase Auth or Firestore user data
    final String userName = "Aditya Kumar";
    final String email = "aditya@example.com";
    final String goal = "Muscle Gain";

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/portrait-young-handsome-man-white-shirt-outdoor-portrait-young-handsome-man-white-shirt-outdoor-nice-appearance-131934608.jpg'), // Replace with user image
                  ),
                  const SizedBox(height: 10),
                  Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("Your Goal", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(goal, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            const Text("Enrolled Programs", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text("Powerlifting HIT"),
              subtitle: const Text("4 weeks · Strength Building"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to detailed program
              },
            ),
            const Divider(),
            const SizedBox(height: 20),
            const Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("App Settings"),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () {
                // Implement Firebase Auth logout
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}