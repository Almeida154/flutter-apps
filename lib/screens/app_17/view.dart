import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App17 extends StatefulWidget {
  const App17({super.key});

  @override
  App17UI createState() => App17UI();
}

class App17UI extends State<App17> {
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
