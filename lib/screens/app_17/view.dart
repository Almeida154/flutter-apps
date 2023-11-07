import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/header.dart';
import '../../widgets/input.dart';

import '../../models/product.dart';
import '../../helpers/product_helper.dart';

class App17 extends StatefulWidget {
  const App17({Key? key}) : super(key: key);

  @override
  App17UI createState() => App17UI();
}

class App17UI extends State<App17> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  late ProductHelper _db;
  List<Product> _tasks = List<Product>.empty(growable: true);

  _getProducts() async {
    List recoveredTasks = await _db.recoverTasks();
    List<Product> temporaryTasks = List<Product>.empty(growable: true);

    for (var item in recoveredTasks) {
      Product product = Product.fromMap(item);
      temporaryTasks.add(product);
    }

    setState(() {
      _tasks = temporaryTasks;
    });

    temporaryTasks = List<Product>.empty(growable: true);
  }

  _deleteProduct(int id) async {
    await _db.removeTask(id);
    _getProducts();
  }

  _saveProduct({Product? savingTask}) async {
    String title = _titleController.text;
    String quantity = _quantityController.text;

    if (savingTask == null) {
      Product product = Product(title, quantity, DateTime.now().toString());
      await _db.saveTask(product);
    } else {
      savingTask.title = title;
      savingTask.quantity = quantity;
      savingTask.date = DateTime.now().toString();
      await _db.updateTask(savingTask);
    }

    _titleController.clear();
    _quantityController.clear();
    _getProducts();
  }

  _showSaveOrUpdateModal({Product? product}) {
    if (product != null) {
      setState(() {
        _titleController.text = product.title;
        _quantityController.text = product.quantity;
      });
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            title: Text(product == null ? 'Save product' : 'Update product',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onBackground)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Input(
                      controller: _titleController,
                      labelText: 'Title',
                      hintText: 'Product title',
                      keyboardType: TextInputType.text,
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Input(
                      controller: _quantityController,
                      labelText: 'Quantity',
                      hintText: 'Product quantity',
                      keyboardType: TextInputType.text,
                    ))
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _titleController.clear();
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    _saveProduct(savingTask: product);
                    Navigator.pop(context);
                  },
                  child: Text(product == null ? 'Save' : 'Update')),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _db = ProductHelper();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? 'Default Title';

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _tasks.length + 1, // +1 para incluir o cabeçalho
          itemBuilder: (context, index) {
            if (index == 0) return header(context, title);

            final product = _tasks[index - 1];
            return item(
                context, product, _deleteProduct, _showSaveOrUpdateModal);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            _showSaveOrUpdateModal();
          },
          child: const Icon(Icons.add)),
    );
  }
}

Widget item(BuildContext context, Product product, onDelete, onEdit) {
  var formatter = DateFormat('d MMM, HH:mm');

  DateTime convertedDate = DateTime.parse(product.date);
  String formattedDate = formatter.format(convertedDate);
  formattedDate = formattedDate.replaceFirst('.', '');

  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface),
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 8, left: 24, right: 24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(formattedDate,
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                    fontSize: 10)),
            const SizedBox(height: 8),
            Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "quantity: ${product.quantity}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14,
              ),
            )
          ]),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onEdit(product: product);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onDelete(product.id);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Icon(
              Icons.remove_circle_outline,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
            ),
          ),
        )
      ],
    ),
  );
}
