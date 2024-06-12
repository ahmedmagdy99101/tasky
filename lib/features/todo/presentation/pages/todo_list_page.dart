import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasky/config/theme/app_theme.dart';
import 'package:tasky/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:tasky/storage.dart';
import '../../data/models/todo_model.dart';
import '../../domain/entities/todo.dart';
import '../widgets/build_task_card_widget.dart';
import 'package:go_router/go_router.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final PagingController<int, Todo> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<TodoCubit>(context).loadTodos(pageKey);
    });
    BlocProvider.of<TodoCubit>(context).loadTodos(1);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state is TodoLoaded) {
          final isLastPage = state.todos.length < 20;
          if (isLastPage) {
            _pagingController.appendLastPage(state.todos);
          } else {
            final nextPageKey = (_pagingController.nextPageKey ?? 1 ) + 1;
            _pagingController.appendPage(state.todos, nextPageKey);
          }
        } else if (state is TodoError) {
          _pagingController.error = state.message;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Logo',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    context.push('/profile');
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xFF7F7F7F),
                    size: 24,
                  )),
              IconButton(
                  onPressed: () {
                    AppSharedPreferences.sharedPreferences.remove("accessToken");
                    context.replace("/login");
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: AppTheme.primaryColor,
                    size: 24,
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "My Tasks",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: const Color(0xFF24252C).withOpacity(0.6)),
                      ),
                    )),
                15.verticalSpace,
                Expanded(
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      children: <Widget>[
                        ButtonsTabBar(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          buttonMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(24)),
                          unselectedDecoration: BoxDecoration(
                              color: const Color(0xFFF0ECFF),
                              borderRadius: BorderRadius.circular(24)),
                          radius: 24,
                          unselectedLabelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          tabs: const [
                            Tab(
                              text: 'All',
                            ),
                            Tab(
                              text: 'InProgress',
                            ),
                            Tab(
                              text: 'Waiting',
                            ),
                            Tab(
                              text: 'Finished',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              PagedListView<int, Todo>(
                                pagingController: _pagingController,
                                builderDelegate: PagedChildBuilderDelegate<Todo>(
                                  itemBuilder: (context, item, index) => GestureDetector(
                                    onTap: () {
                                      context.push("/todo", extra: item);
                                    },
                                    child: BuildTaskCardWidget(todoData: item),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: TodoCubit.inProgressList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.push("/todo", extra: TodoCubit.inProgressList[index]);
                                    },
                                    child: BuildTaskCardWidget(todoData: TodoCubit.inProgressList[index]),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: TodoCubit.waitingList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.push("/todo", extra: TodoCubit.waitingList[index]);
                                    },
                                    child: BuildTaskCardWidget(todoData: TodoCubit.waitingList[index]),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: TodoCubit.finishedList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.push("/todo", extra: TodoCubit.finishedList[index]);
                                    },
                                    child: BuildTaskCardWidget(todoData: TodoCubit.finishedList[index]),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 50.0,
                height: 50.0,
                child: FloatingActionButton(
                  heroTag: 'barcodeFab',
                  elevation: 0,
                  backgroundColor: AppTheme.secondaryColor,
                  onPressed: () {
                    setState(() {});
                  },
                  child: Image.asset(
                    'assets/icons/barcode.png',
                    width: 24,
                    height: 24,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              14.verticalSpace,
              SizedBox(
                width: 64.0,
                height: 64.0,
                child: FloatingActionButton(
                  heroTag: 'addTodoFab',
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: () {
                    context.push('/addTodo').then((value) {
                      BlocProvider.of<TodoCubit>(context).loadTodos(1);
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}