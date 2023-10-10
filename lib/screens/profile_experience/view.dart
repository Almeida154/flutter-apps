import 'package:flutter/material.dart';

import '../../widgets/header.dart';

class ProfileExperience extends StatefulWidget {
  const ProfileExperience({super.key});

  @override
  ProfileExperienceUI createState() => ProfileExperienceUI();
}

class ProfileExperienceUI extends State<ProfileExperience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        header(context, 'Experience'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface),
            child: Text(
              'Experience',
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
