import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import 'package:go_router/go_router.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  onTap: () {
                    context.push('/todo/${todo.id}');
                  },
                );
              },
            );
          } else if (state is TodoFailure) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No Todos'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addTodo');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
