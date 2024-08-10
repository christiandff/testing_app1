import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove the shadow
        centerTitle: true, // Center the title
        title: const Text(
          'Leaderboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Increase font size
        ),
      ),
      body: const Center(
        child: Text('Leaderboard functionality has been removed.'),
      ),
    );
  }
}
