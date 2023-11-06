import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App16 extends StatefulWidget {
  const App16({super.key});

  @override
  App16UI createState() => App16UI();
}

class App16UI extends State<App16> {
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
