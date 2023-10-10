import 'package:flutter/material.dart';

import '../../widgets/header.dart';

class ProfilePersonal extends StatefulWidget {
  const ProfilePersonal({super.key});

  @override
  ProfilePersonalUI createState() => ProfilePersonalUI();
}

class ProfilePersonalUI extends State<ProfilePersonal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        header(context, 'Personal'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface),
            child: Text(
              'Personal',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
