import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/info.dart';
import 'widgets/apps_list.dart';

class Apps extends StatelessWidget {
  const Apps({super.key, Key? apps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Header(),
                const SizedBox(height: 32),
                info(context),
                const SizedBox(height: 32),
                appsList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
