import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App21 extends StatefulWidget {
  const App21({super.key});

  @override
  App21UI createState() => App21UI();
}

class App21UI extends State<App21> {
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
