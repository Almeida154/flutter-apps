import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../widgets/header.dart';
import '../../providers/theme.dart';

class App15 extends StatefulWidget {
  const App15({Key? key}) : super(key: key);

  @override
  App15UI createState() => App15UI();
}

class App15UI extends State<App15> {
  bool _isDay = true;
  bool _isSmall = false;
  bool _isSaving = false;

  _loadPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _isDay = preferences.getBool('isDay') ?? true;
      _isSmall = preferences.getBool('isSmall') ?? false;
    });
  }

  Future<void> _saveSharedPreference(String key, bool value) async {
    if (_isSaving) return;
    _isSaving = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
    _isSaving = false;
  }

  void _toggleDay(bool value) {
    setState(() {
      _isDay = value;
      _saveSharedPreference('isDay', value);
    });
  }

  void _toggleSize(bool value) {
    setState(() {
      _isSmall = value;
      _saveSharedPreference('isSmall', value);
    });
  }

  Color _getBackgroundColor() {
    if (Provider.of<ThemeProvider>(context).isDarkMode) {
      return _isDay
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.surface;
    }

    return _isDay
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.onBackground;
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? 'Default Title';

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        header(context, title),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
          child: Row(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Day',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground)),
                const SizedBox(width: 8),
                Switch(
                  value: _isDay,
                  onChanged: _toggleDay,
                ),
              ],
            ),
            const SizedBox(width: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Small',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground)),
                const SizedBox(width: 8),
                Switch(
                  value: _isSmall,
                  onChanged: _toggleSize,
                ),
              ],
            )
          ]),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _getBackgroundColor()),
          child: Text(
            'Revenge is never as good as it is expected to be. It poisons and kills your soul.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _isSmall ? 16 : 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ])),
    );
  }
}
