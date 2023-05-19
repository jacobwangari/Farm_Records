import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Trace App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dairy');
                },
                child: const Text('Dairy'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/layers');
                },
                child: const Text('Layers'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
              SizedBox(
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/report');
                },
                child: const Text('Farm Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
