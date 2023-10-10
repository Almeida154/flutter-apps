import 'package:flutter/material.dart';

import '../../widgets/header.dart';

class ProfileFormation extends StatefulWidget {
  const ProfileFormation({super.key});

  @override
  ProfileFormationUI createState() => ProfileFormationUI();
}

class ProfileFormationUI extends State<ProfileFormation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        header(context, 'Formation'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface),
            child: Text(
              'Formation',
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
