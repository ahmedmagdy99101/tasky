import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/config/theme/app_theme.dart';
import '../cubit/todo_cubit.dart';
import 'package:go_router/go_router.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logo',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w700),),
        actions: [
          IconButton(onPressed:(){}, icon: const Icon(Icons.account_circle_outlined ,color: Color(0xFF7F7F7F),size: 24,)),
          IconButton(onPressed:(){}, icon: const Icon(Icons.logout ,color: AppTheme.primaryColor,size: 24,)),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
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
          return const Center(child: Text('No Todos'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addTodo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
