import 'package:flutter/material.dart';
import 'widgets/menu_item.dart';

class Apps extends StatelessWidget {
  const Apps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: ListView(
        children: <Widget>[
          menuItem(context, '#01 - Meu Perfil', '/app01'),
          menuItem(context, '#02 - Contador de pessoas', '/app02'),
        ],
      ),
    ));
  }
}
