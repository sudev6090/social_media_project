import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/services/auth_service.dart';

class PasswordChangeScreen extends StatelessWidget {
  PasswordChangeScreen({super.key});

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: Colors.black12),
            child: Padding(
              padding: const EdgeInsets.all(55.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: passwordController,
                    decoration:
                        const InputDecoration(hintText: 'Enter a new password'),
                  ),
                  const Gap(30),
                  ElevatedButton(
                      onPressed: () async {
                        await AuthService()
                            .changePassword(context, passwordController.text);
                        passwordController.clear();
                      },
                      child: const Text('Change password'))
                ],
              ),
            )));
  }
}
