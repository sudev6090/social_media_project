import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserDetails extends StatelessWidget {
  final String name;
  final String email;
  final String followers;
  final String following;
  const UserDetails({
    super.key,
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(email),
            Text('Following: $followers'),
            Text('Followrs: $following'),
          ],
        ),
      ),
    );
  }
}
