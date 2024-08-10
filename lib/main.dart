import 'package:flutter/material.dart';
// Removed the Firebase import for Leaderboard since Firebase is no longer used.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          primary: Colors.redAccent,
          secondary: Colors.orangeAccent,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hvem henger etter..'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _score = 0;

  void _addScore(int points) {
    setState(() {
      _score += points;
    });
  }

  void _resetScore() {
    setState(() {
      _score = 0;
    });
  }

  Future<void> _confirmReset() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bekreft tilbakestill'),
          content: const Text('Ønsker du å tilbakestille scoreen din?'),
          actions: <Widget>[
            TextButton(
              child: const Text('avbryt'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('tilbakestill'),
              onPressed: () {
                _resetScore(); // Reset the score
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove the shadow
        centerTitle: true, // Center the title
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Increase font size
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _confirmReset, // Confirm reset before resetting
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/flames.png'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Hvem henger etter..',
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: Text(
                          '$_score',
                          key: ValueKey<int>(_score),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildScoreButton(context, 'Øl/Cider', 10, Icons.local_drink),
              _buildScoreButton(context, 'Smirnoff/Breezer', 5, Icons.science),
              _buildScoreButton(context, 'Vodka Redbull/Drink', 10, Icons.local_bar),
              _buildScoreButton(context, 'Shot', 20, Icons.local_bar),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreButton(BuildContext context, String label, int points, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () => _addScore(points),
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
