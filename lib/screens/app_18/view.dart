import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App18 extends StatefulWidget {
  const App18({super.key});

  @override
  App18UI createState() => App18UI();
}

class App18UI extends State<App18> {
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
