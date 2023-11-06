import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App19 extends StatefulWidget {
  const App19({super.key});

  @override
  App19UI createState() => App19UI();
}

class App19UI extends State<App19> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? 'Default Title';

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        header(context, title),
        Container(),
      ])),
    );
  }
}
