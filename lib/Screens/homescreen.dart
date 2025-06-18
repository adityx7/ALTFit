import 'package:flutter/material.dart';
import 'programs_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AltFit Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProgramsScreen()),
            );
          },
          child: Text('Explore Programs'),
        ),
      ),
    );
  }
}