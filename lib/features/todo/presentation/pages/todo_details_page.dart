import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../cubit/todo_cubit.dart';
import '../../domain/entities/todo.dart';

class TodoDetailsPage extends StatelessWidget {
  final String id;

  TodoDetailsPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final todo = context.select<TodoCubit, Todo?>(
          (cubit) => (cubit.state as TodoLoaded).todos.firstWhere((todo) => todo.id == id),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(todo?.title ?? 'Todo Details'),
      ),
      body: todo == null
          ? Center(child: Text('Todo not found'))
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${todo.title}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Description: ${todo.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            todo.imageUrl.isNotEmpty
                ? Image.network(todo.imageUrl)
                : Container(),
            SizedBox(height: 20),
            QrImageView(
              data: todo.id,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
