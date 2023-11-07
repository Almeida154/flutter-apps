import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../widgets/header.dart';
import '../../widgets/input.dart';
import '../../widgets/dropdown.dart';

class App20 extends StatefulWidget {
  const App20({Key? key}) : super(key: key);

  @override
  App20UI createState() => App20UI();
}

class App20UI extends State<App20> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedFromCurrency = 'Real (BRL)';
  String _selectedToCurrency = 'Dollar (USD)';
  String _result = '-';

  final Map<String, String> _currencyCodes = {
    'Real (BRL)': 'BRL',
    'Dollar (USD)': 'USD',
    'Euro (EUR)': 'EUR',
    'Bitcoin (BTC)': 'BTC',
  };

  void _convertCurrency() async {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    String fromCurrencyRate = _currencyCodes[_selectedFromCurrency] ?? '';
    String toCurrencyRate = _currencyCodes[_selectedToCurrency] ?? '';

    try {
      String url =
          'https://economia.awesomeapi.com.br/json/last/${toCurrencyRate}-${fromCurrencyRate}';

      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> mappedResponse = json.decode(response.body);

      double currencyRate = double.parse(
          mappedResponse[toCurrencyRate + fromCurrencyRate]['ask']);

      double result = amount * currencyRate;

      setState(() {
        _result =
            NumberFormat.currency(symbol: '', decimalDigits: 2).format(result);
      });
    } catch (e) {
      setState(() {
        _result = 'An error ocurred!';
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Input(
                controller: _amountController,
                labelText: 'Amount',
                hintText: 'Fill the amount to be converted',
                keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            Dropdown<String>(
              labelText: 'From',
              value: _selectedFromCurrency,
              items: _currencyCodes.keys
                  .map((currency) => currency.toString())
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedFromCurrency = newValue!;
                });
              },
            ),
            const SizedBox(height: 24),
            Dropdown<String>(
              labelText: 'To',
              value: _selectedToCurrency,
              items: _currencyCodes.keys
                  .map((currency) => currency.toString())
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedToCurrency = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
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
          child: Text(
            _result,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    )));
  }
}
