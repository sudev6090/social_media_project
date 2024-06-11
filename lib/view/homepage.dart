import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 87, 28, 28),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black12),
          child: const Center(
            child: Text(
              'HomeScreen',
              style: TextStyle(
                color: Color.fromARGB(255, 160, 115, 115),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ));
  }
}
