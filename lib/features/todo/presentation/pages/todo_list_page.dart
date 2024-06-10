import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasky/config/theme/app_theme.dart';
import 'package:tasky/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:tasky/storage.dart';
import '../../data/models/todo_model.dart';
import '../widgets/build_task_card_widget.dart';
import 'package:go_router/go_router.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final PagingController<int, TodoModel> _pagingController =
  PagingController(firstPageKey: 0);
  // int page = 1;
  @override
  void initState() {
    BlocProvider.of<TodoCubit>(context).loadTodos(1);
    // TodoCubit.pagingController.addPageRequestListener((pageKey) {
    //   BlocProvider.of<TodoCubit>(context).loadTodos(pageKey);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
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
                    AppSharedPreferences.sharedPreferences
                        .remove("accessToken");
                    context.replace("/login");
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: AppTheme.primaryColor,
                    size: 24,
                  )),
            ],
          ),
          body: state is TodoLoading
              ? const Center(child: CircularProgressIndicator())
              : state is TodoLoaded
              ? Padding(
            padding: const EdgeInsets.only(
                top: 20, bottom: 20, left: 10, right: 5),
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
                            color: const Color(0xFF24252C)
                                .withOpacity(0.6)),
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
                          buttonMargin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius:
                              BorderRadius.circular(24)),
                          unselectedDecoration: BoxDecoration(
                              color: const Color(0xFFF0ECFF),
                              borderRadius:
                              BorderRadius.circular(24)),
                          radius: 24,
                          // unselectedBackgroundColor: Color(0xFFF0ECFF),
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
                              ListView.builder(
                                  itemCount: state.todos.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          context.push("/todo",
                                              extra:
                                              state.todos[index]);
                                        },
                                        child: BuildTaskCardWidget(
                                          todoData:
                                          state.todos[index],
                                        ));
                                  }),
                              ListView.builder(
                                  itemCount:
                                  TodoCubit.inProgressList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.push("/todo",
                                            extra:
                                            TodoCubit
                                                .inProgressList[index]);
                                      },
                                      child: BuildTaskCardWidget(
                                        todoData: TodoCubit
                                            .inProgressList[index],
                                      ),
                                    );
                                  }),
                              ListView.builder(
                                  itemCount:
                                  TodoCubit.waitingList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.push("/todo",
                                            extra:
                                            TodoCubit
                                                .waitingList[index]);
                                      },
                                      child: BuildTaskCardWidget(
                                        todoData: TodoCubit
                                            .waitingList[index],
                                      ),
                                    );
                                  }),
                              ListView.builder(
                                  itemCount:
                                  TodoCubit.finishedList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.push("/todo",
                                            extra:
                                            TodoCubit
                                                .finishedList[index]);
                                      },
                                      child: BuildTaskCardWidget(
                                        todoData: TodoCubit
                                            .finishedList[index],
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
              : Center(
            child: ElevatedButton(
              onPressed: () {
                context.replace('/login');
                AppSharedPreferences.sharedPreferences
                    .remove("accessToken");
              },
              style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all(AppTheme.primaryColor),
                  shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  fixedSize:
                  WidgetStateProperty.all(Size(331.w, 49.h))),
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
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
                    //  context.push('/profile');
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
                    context.push('/addTodo');
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