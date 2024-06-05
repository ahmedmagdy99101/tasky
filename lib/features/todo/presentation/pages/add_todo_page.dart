import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../../domain/entities/todo.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});
  @override
  AddTodoPageState createState() => AddTodoPageState();
}

class AddTodoPageState extends State<AddTodoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }
    final todo = Todo(createdAt: DateTime.now(),
      id: '',
      title: _titleController.text,
      description: _descriptionController.text,
      imageUrl: _image?.path ?? '', priority: '', status: '', user: '', updatedAt: DateTime.now(),
    );
    context.read<TodoCubit>().addTodo(todo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            _image == null
                ? TextButton.icon(
              icon: Icon(Icons.image),
              label: Text('Pick Image'),
              onPressed: _pickImage,
            )
                : Image.file(File(_image!.path)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
