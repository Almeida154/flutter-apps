import 'package:flutter/material.dart';

Widget appsList2(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Checkpoint #6',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        item(context, '15', 'Shared Preferences', '/app15'),
        item(context, '16', 'Tasks todo', '/app16'),
        item(context, '17', 'Shopping list', '/app17'),
        item(context, '18', '(API) Address inquiry', '/app18'),
        item(context, '19', '(API) GitHub profile', '/app19'),
        item(
            context,
            '20',
            '(API) Currency converter - Real, Dollar, Euro and Bitcoin',
            '/app20'),
        item(context, '21', '(API) Fiap Movies', '/app21'),
      ]));
}

Widget item(BuildContext context, String number, String title, String route) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route, arguments: {'title': title});
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface),
      padding: const EdgeInsets.only(bottom: 16, top: 16, right: 16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft:
                      Radius.circular(24), // Radius for the top left corner
                  bottomRight:
                      Radius.circular(24), // Radius for the bottom right corner
                ),
                color: Theme.of(context).colorScheme.primary),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(number,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12))),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('VER',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12))
        ],
      ),
    ),
  );
}
