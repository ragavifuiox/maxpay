import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.rocket_launch_rounded, size: 90),

                const SizedBox(height: 30),

                const Text(
                  'Coming Soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Text(
                  'We’re working hard to bring something amazing to you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                ElevatedButton(
                  onPressed: () {
                    // Optional action
                  },
                  child: const Text('Stay Tuned'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
