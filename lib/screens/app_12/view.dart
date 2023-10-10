import 'package:flutter/material.dart';

import '../profile_personal/view.dart';
import '../profile_formation/view.dart';
import '../profile_experience.dart/view.dart';

import '../../widgets/header.dart';

class App12 extends StatefulWidget {
  const App12({Key? key}) : super(key: key);

  @override
  App12UI createState() => App12UI();
}

class App12UI extends State<App12> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? 'Default Title';

    return Scaffold(
      key: _scaffoldKey,
      drawer: _drawer(context),
      body: SafeArea(
          child: Column(children: [
        header(context, title),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: const Text('Open Drawer'),
          ),
        )
      ])),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: ListView(
        children: [
          Column(children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 132,
              height: 132,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(132 / 2),
                child: SizedBox(
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/56116502?v=4',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('David Almeida',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(height: 32),
            ListTile(
              title: Text(
                'Personal',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePersonal(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Formation',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileFormation(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Experience',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileExperience(),
                  ),
                );
              },
            ),
          ]),
        ],
      ),
    );
  }
}
