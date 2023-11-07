import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/app_21_details/view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../widgets/header.dart';

class App21 extends StatefulWidget {
  const App21({super.key});

  @override
  App21UI createState() => App21UI();
}

class App21UI extends State<App21> {
  List<dynamic> _movies = List<dynamic>.empty(growable: true);

  void _getMovies() async {
    try {
      String url = 'https://sujeitoprogramador.com/r-api/?api=filmes';
      http.Response response = await http.get(Uri.parse(url));
      setState(() => _movies = json.decode(response.body));
    } catch (e) {
      // Some error ocurred
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? 'Default Title';

    return Scaffold(
      body: _movies.isNotEmpty
          ? ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      child: _movies.isNotEmpty
                          ? Transform.translate(
                              offset: const Offset(0, -60),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Opacity(
                                      opacity: .7,
                                      child: Image.network(
                                        _movies[0]["foto"],
                                        height: 420,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(children: [
                                      carousel(
                                          context,
                                          _movies.sublist(
                                              1, _movies.length ~/ 1.5),
                                          'Continue watching'),
                                      const SizedBox(height: 16),
                                      carousel(
                                          context,
                                          _movies
                                              .sublist(_movies.length ~/ 1.5),
                                          'Popular on Fiap Movies'),
                                    ])
                                  ]),
                            )
                          : Container(),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 420 - 60,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                              ),
                            ),
                          ),
                          Transform.translate(
                              offset: const Offset(0, -160),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(_movies[0]["nome"],
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: header(context, title),
                    ),
                  ],
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      backgroundColor: Colors.black,
    );
  }
}

Widget carousel(BuildContext context, List<dynamic> movies, String label) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white))),
    const SizedBox(height: 16),
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: movies.asMap().entries.map((entry) {
            final index = entry.key;
            final movie = entry.value;

            return Padding(
              padding: EdgeInsets.only(left: index > 0 ? 16 : 0),
              child: item(context, movie),
            );
          }).toList(),
        ),
      ),
    )
  ]);
}

Widget item(BuildContext context, dynamic movie) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return App21Details(movie: movie);
          },
        ),
      );
    },
    child: Container(
      width: 180,
      height: 220,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                movie["foto"],
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(.9)
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie["nome"],
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('WATCH',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary)),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    ),
  );
}
