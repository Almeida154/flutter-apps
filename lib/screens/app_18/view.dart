import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../widgets/header.dart';
import '../../widgets/input.dart';

class App18 extends StatefulWidget {
  const App18({super.key});

  @override
  App18UI createState() => App18UI();
}

class App18UI extends State<App18> {
  final TextEditingController _zipCodeController = TextEditingController();

  String _place = '-';
  String _neighborhood = '-';
  String _locality = '-';
  String _state = '-';
  String _zipCode = '-';

  void _getAddress() async {
    try {
      String url = 'https://viacep.com.br/ws/${_zipCodeController.text}/json/';

      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> mappedResponse = json.decode(response.body);

      setState(() {
        _place = mappedResponse["logradouro"];
        _neighborhood = mappedResponse["bairro"];
        _locality = mappedResponse["localidade"];
        _state = mappedResponse["uf"];
        _zipCode = _zipCodeController.text;
      });
    } catch (e) {
      setState(() {
        _place = '-';
        _neighborhood = '-';
        _locality = '-';
        _state = '-';
        _zipCode = '-';
      });
    }
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(children: [
              Expanded(
                child: Input(
                    controller: _zipCodeController,
                    labelText: 'Zip Code',
                    hintText: 'What is the zip code?',
                    keyboardType: TextInputType.number),
              ),
              const SizedBox(width: 16),
              SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // Button border radius
                    ),
                  ),
                  onPressed: _getAddress,
                  child: const Center(child: Icon(Icons.search)),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Place',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _place,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Neighborhood',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _neighborhood,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Locality',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _locality,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'State',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _state,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Zip code',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _zipCode,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
