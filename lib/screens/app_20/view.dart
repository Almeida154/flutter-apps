import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App20 extends StatefulWidget {
  const App20({super.key});

  @override
  App20UI createState() => App20UI();
}

class App20UI extends State<App20> {
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
