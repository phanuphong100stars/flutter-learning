import 'package:flutter/material.dart';

/// Flutter code sample for [AppBar].

void main() => runApp(const MyFirstApp());

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MyFirstApp(),
    );
  }
}

class _MyFirstApp extends StatelessWidget {
  const _MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page ddd',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
