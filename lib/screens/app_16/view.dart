import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/header.dart';
import '../../widgets/input.dart';

import '../../models/task.dart';
import '../../helpers/task_helper.dart';

class App16 extends StatefulWidget {
  const App16({Key? key}) : super(key: key);

  @override
  App16UI createState() => App16UI();
}

class App16UI extends State<App16> {
  final TextEditingController _titleController = TextEditingController();
  late TaskHelper _db;
  List<Task> _tasks = List<Task>.empty(growable: true);

  _getTasks() async {
    List recoveredTasks = await _db.recoverTasks();
    List<Task> temporaryTasks = List<Task>.empty(growable: true);

    for (var item in recoveredTasks) {
      Task task = Task.fromMap(item);
      temporaryTasks.add(task);
    }

    setState(() {
      _tasks = temporaryTasks;
    });

    temporaryTasks = List<Task>.empty(growable: true);
  }

  _deleteTask(int id) async {
    await _db.removeTask(id);
    _getTasks();
  }

  _saveTask({Task? savingTask}) async {
    String title = _titleController.text;

    if (savingTask == null) {
      Task task = Task(title, DateTime.now().toString());
      await _db.saveTask(task);
    } else {
      savingTask.title = title;
      savingTask.date = DateTime.now().toString();
      await _db.updateTask(savingTask);
    }

    _titleController.clear();
    _getTasks();
  }

  _showSaveOrUpdateModal({Task? task}) {
    if (task != null) {
      setState(() {
        _titleController.text = task.title;
      });
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            title: Text(task == null ? 'Save task' : 'Update task',
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
                      hintText: 'Task title',
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
                    _saveTask(savingTask: task);
                    Navigator.pop(context);
                  },
                  child: Text(task == null ? 'Save' : 'Update')),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _db = TaskHelper();
    _getTasks();
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

            final task = _tasks[index - 1];
            return item(context, task, _deleteTask, _showSaveOrUpdateModal);
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

Widget item(BuildContext context, Task task, onDelete, onEdit) {
  var formatter = DateFormat('d MMM, HH:mm');

  DateTime convertedDate = DateTime.parse(task.date);
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
        Container(
            margin: const EdgeInsets.only(right: 16),
            child: Text(formattedDate,
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                    fontSize: 10))),
        Expanded(
          child: Text(
            task.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onEdit(task: task);
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
            onDelete(task.id);
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
