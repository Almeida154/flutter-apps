import 'package:flutter/material.dart';

import '../../widgets/header.dart';

class App21Details extends StatefulWidget {
  final dynamic movie;

  const App21Details({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  App21DetailsUI createState() => App21DetailsUI();
}

class App21DetailsUI extends State<App21Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              header(context, widget.movie["nome"]),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image.network(
                        widget.movie["foto"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surface),
                child: Text(
                  widget.movie["sinopse"],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
