import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App15 extends StatefulWidget {
  const App15({super.key});

  @override
  App15UI createState() => App15UI();
}

class App15UI extends State<App15> {
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
