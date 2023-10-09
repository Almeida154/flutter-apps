import 'package:flutter/material.dart';
import '../../widgets/header.dart';

class App07 extends StatelessWidget {
  const App07({super.key, Key? app01});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? 'Default Title';

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          header(context, title),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    item(
                        context,
                        'https://imgnike-a.akamaihd.net/250x250/027648DD.jpg',
                        'Jordan x J Balvin',
                        'Casual',
                        399.99),
                    const SizedBox(width: 8),
                    item(
                        context,
                        'https://imgnike-a.akamaihd.net/250x250/025685NX.jpg',
                        'Bolsa Transversal Nike Heritage Unissex',
                        'Treino & Academia',
                        229.99),
                    const SizedBox(width: 8),
                    item(
                        context,
                        'https://imgnike-a.akamaihd.net/360x360/027173BP.jpg',
                        'Camiseta Jordan Paris Saint-Germain Masculina',
                        'Casual',
                        249.99),
                    const SizedBox(width: 8),
                    item(
                        context,
                        'https://imgnike-a.akamaihd.net/360x360/0137025B.jpg',
                        'Tênis Nike Court Vision Low Next Nature Masculino',
                        'Casual',
                        539.99),
                  ],
                ),
              ))
        ],
      )),
    );
  }

  Widget item(BuildContext context, String src, String title,
      String description, double price) {
    void onAddToCart() {}

    return Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surface),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  src,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'R\$ $price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onAddToCart,
              child: const Text('Add to cart'),
            )
          ],
        ));
  }
}
