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
  final PagingController<int, TodoModel> _pagingController = PagingController(firstPageKey: 0);
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
          body: state is TodoLoading ?
          const Center(child: CircularProgressIndicator()) :
          state is TodoLoaded ? Padding(
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
                          buttonMargin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(24)),
                          unselectedDecoration: BoxDecoration(
                              color: const Color(0xFFF0ECFF),
                              borderRadius: BorderRadius.circular(24)),
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
                                    return  BuildTaskCardWidget(todoData: state.todos[index],);
                                  }),
                              ListView.builder(
                                  itemCount:
                                  TodoCubit.inProgressList.length,
                                  itemBuilder: (context, index) {
                                    return  BuildTaskCardWidget(todoData: TodoCubit.inProgressList[index],);
                                  }),
                              ListView.builder(
                                  itemCount: TodoCubit.waitingList.length,
                                  itemBuilder: (context, index) {
                                    return  BuildTaskCardWidget(todoData: TodoCubit.waitingList[index],);
                                  }),
                              ListView.builder(
                                  itemCount: TodoCubit.finishedList.length,
                                  itemBuilder: (context, index) {
                                    return  BuildTaskCardWidget(todoData: TodoCubit.finishedList[index],);
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
          ): Center(
            child: ElevatedButton(
              onPressed: () {
                context.replace('/login');
                AppSharedPreferences.sharedPreferences.remove("accessToken");
              },
              style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all(AppTheme.primaryColor),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  fixedSize: WidgetStateProperty.all(Size(331.w, 49.h))),
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

/*
        if (state is TodoLoading) {
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
            body: Padding(
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
                            buttonMargin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(24)),
                            unselectedDecoration: BoxDecoration(
                                color: const Color(0xFFF0ECFF),
                                borderRadius: BorderRadius.circular(24)),
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
        } else if (state is TodoLoaded) {
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
            body: Padding(
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
                            buttonMargin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(24)),
                            unselectedDecoration: BoxDecoration(
                                color: const Color(0xFFF0ECFF),
                                borderRadius: BorderRadius.circular(24)),
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
                                      return  BuildTaskCardWidget(todoData: state.todos[index],);
                                    }),
                                ListView.builder(
                                    itemCount:
                                    TodoCubit.inProgressList.length,
                                    itemBuilder: (context, index) {
                                      return  BuildTaskCardWidget(todoData: TodoCubit.inProgressList[index],);
                                    }),
                                ListView.builder(
                                    itemCount: TodoCubit.waitingList.length,
                                    itemBuilder: (context, index) {
                                      return  BuildTaskCardWidget(todoData: TodoCubit.waitingList[index],);
                                    }),
                                ListView.builder(
                                    itemCount: TodoCubit.finishedList.length,
                                    itemBuilder: (context, index) {
                                      return  BuildTaskCardWidget(todoData: TodoCubit.finishedList[index],);
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
        } else {
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
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  context.replace('/login');
                  AppSharedPreferences.sharedPreferences.remove("accessToken");
                },
                style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(AppTheme.primaryColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    fixedSize: WidgetStateProperty.all(Size(331.w, 49.h))),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          );
        }
 */
/*
BlocBuilder<TodoCubit, TodoState>(
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
      )
 */
/*
/// Waiting


        Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          Column(
                            children: [
                              BuildTaskCardWidget(),
                              Container(
                                width: 1.sw,
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 5),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/item_image.png',
                                      width: 64.w,
                                      height: 64.h,
                                    ),
                                    10.horizontalSpace,
                                    SizedBox(
                                      width: 225.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Grocery Shopping App",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.sp,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              5.horizontalSpace,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFE4F2),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Text(
                                                  "Waiting",
                                                  style: TextStyle(
                                                      color: Color(0xFFFF7D53)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "This application is designed for super shops. By using",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: const Color(0x24252C99)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                      Icons.flag_outlined,
                                                      size: 16,
                                                      color: Color(0xFF0087FF)),
                                                  1.horizontalSpace,
                                                  Text(
                                                    "Low",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color:
                                                            Color(0xFF0087FF)),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "30/12/2022",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_vert_outlined,
                                          color: Colors.black,
                                          size: 24,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                width: 1.sw,
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 5),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/item_image.png',
                                      width: 64.w,
                                      height: 64.h,
                                    ),
                                    10.horizontalSpace,
                                    SizedBox(
                                      width: 225.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Grocery Shopping App",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.sp,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              5.horizontalSpace,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFF0ECFF),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Text(
                                                  "Inprogress",
                                                  style: TextStyle(
                                                      color:

                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "This application is designed for super shops. By using",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: const Color(0x24252C99)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                      Icons.flag_outlined,
                                                      size: 16,
                                                      color: Color(0xFFFF7D53)),
                                                  1.horizontalSpace,
                                                  Text(
                                                    "Heigh",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color:
                                                            Color(0xFFFF7D53)),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "30/12/2022",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_vert_outlined,
                                          color: Colors.black,
                                          size: 24,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                width: 1.sw,
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 5),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/item_image.png',
                                      width: 64.w,
                                      height: 64.h,
                                    ),
                                    10.horizontalSpace,
                                    SizedBox(
                                      width: 225.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Grocery Shopping App",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.sp,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              5.horizontalSpace,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE3F2FF),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Text(
                                                  "Finished",
                                                  style: TextStyle(
                                                      color: Color(0xFF0087FF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "This application is designed for super shops. By using",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: const Color(0x24252C99)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                      Icons.flag_outlined,
                                                      size: 16,
                                                      color: AppTheme
                                                          .primaryColor),
                                                  1.horizontalSpace,
                                                  Text(
                                                    "Medium",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color: AppTheme
                                                            .primaryColor),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "30/12/2022",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.horizontalSpace,
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_vert_outlined,
                                          color: Colors.black,
                                          size: 24,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(),
                          Container(),
                          Container(),
                        ],
                      ),
                    ),
 */