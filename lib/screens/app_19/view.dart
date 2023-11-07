import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../widgets/header.dart';
import '../../widgets/input.dart';

class App19 extends StatefulWidget {
  const App19({super.key});

  @override
  App19UI createState() => App19UI();
}

class App19UI extends State<App19> {
  final TextEditingController _usernameController = TextEditingController();

  dynamic _avatar;
  String _id = '-';
  String _name = '-';
  int _repositories = 0;
  String _createdAt = '-';
  int _followers = 0;
  int _following = 0;

  void _getAddress() async {
    try {
      String url = 'https://api.github.com/users/${_usernameController.text}';

      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> mappedResponse = json.decode(response.body);

      DateTime parsedDate = DateTime.parse(mappedResponse["created_at"]);
      String formattedDate = DateFormat('y MMM dd').format(parsedDate);

      setState(() {
        _avatar = mappedResponse["avatar_url"];
        _id = mappedResponse["node_id"];
        _name = mappedResponse["name"];
        _repositories = mappedResponse["public_repos"];
        _createdAt = formattedDate;
        _followers = mappedResponse["followers"];
        _following = mappedResponse["following"];
      });
    } catch (e) {
      setState(() {
        _avatar = null;
        _id = '-';
        _name = '-';
        _repositories = 0;
        _createdAt = '-';
        _followers = 0;
        _following = 0;
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
          Container(
              child: _avatar != null && _avatar.isNotEmpty
                  ? Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(_avatar),
                          radius: 64,
                        ),
                        const SizedBox(height: 40),
                      ],
                    )
                  : null),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(children: [
              Expanded(
                child: Input(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'What is the username?',
                    keyboardType: TextInputType.text),
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
                    'Id',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _id,
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
                    'Name',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _name,
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
                    'Repositories',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _repositories.toString(),
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
                    'Created at',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _createdAt,
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
                    'Followers',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _followers.toString(),
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
                    'Following',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _following.toString(),
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
