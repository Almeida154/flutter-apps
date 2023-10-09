import 'package:flutter/material.dart';

Widget appsList(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Checkpoint #2',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        item(context, '7', 'Ads for selling products', '/app07'),
        item(context, '8', 'IT job openings', '/app08'),
        item(context, '9', 'Currency Converter - Real, Dollar and Euro',
            '/app09'),
        item(context, '10', 'Bank account opening form', '/app10'),
        item(context, '11', 'Two screens bank account opening form with',
            '/app11'),
        item(context, '12', 'My Profile with Drawer Navigation', '/app12'),
        item(context, '13', 'My Profile with Bottom Navigation Bar', '/app13'),
        item(context, '14', 'My Profile with Tab Bar', '/app14'),
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
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              number,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
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
          Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    ),
  );
}
