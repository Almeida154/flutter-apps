import 'package:flutter/material.dart';
import 'list_horizontal_item.dart';

Widget appsList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      listHorizontalItem(context, '#01 - Meu Perfil', '/app01'),
      listHorizontalItem(context, '#02 - Contador de pessoas', '/app02'),
    ],
  );
}
