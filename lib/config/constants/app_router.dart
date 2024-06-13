import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/config/constants/app_strings.dart';
import 'package:tasky/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tasky/features/todo/domain/entities/todo.dart';
import 'package:tasky/features/todo/presentation/cubit/add_todo_cubit/add_todo_cubit.dart';
import 'package:tasky/storage.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/todo/presentation/cubit/single_todo/single_todo_cubit.dart';
import '../../features/todo/presentation/cubit/update_todo_cubit/update_todo_cubit.dart';
import '../../features/todo/presentation/pages/add_todo_page.dart';
import '../../features/todo/presentation/pages/edit_todo_page.dart';
import '../../features/todo/presentation/pages/qr_scanner_page.dart';
import '../../features/todo/presentation/pages/todo_details_page.dart';
import '../../features/todo/presentation/pages/todo_list_page.dart';
import '../../injection_container.dart';

final GoRouter router = GoRouter(
  initialLocation:
      AppSharedPreferences.sharedPreferences.containsKey(AppStrings.accessToken)
          ? "/todos"
          : "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => BlocProvider(
          create: (BuildContext context) =>
              sl<ProfileCubit>()..getProfileDataMethod(),
          child: const ProfilePage()),
    ),
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodoListPage(),
    ),
    GoRoute(
      path: '/addTodo',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<CreateTodoCubit>(),
          child: const AddTodoPage(),
        );
      },
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => BlocProvider(
        create: (BuildContext context) => sl<UpdateTodoCubit>(),
        child: EditTaskPage(
          task: state.extra as Todo,
        ),
      ),
    ),
    GoRoute(
      path: '/todo',
      builder: (context, state) => BlocProvider(
        create: (context) => sl<SingleTodoCubit>(),
        child: TodoDetailsPage(task: state.extra as Todo),
      ),
    ),
    GoRoute(
      path: '/qrScanner',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<SingleTodoCubit>(),
          child: QRScannerPage(),
        );
      },
    ),
  ],
);
//

// final GoRouter router = GoRouter(
//   initialLocation:
//       AppSharedPreferences.sharedPreferences.getString("accessToken") != null
//           ? "/todos"
//           : "/",
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const WelcomePage(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => const LoginPage(),
//     ),
//     GoRoute(
//       path: '/register',
//       builder: (context, state) => const RegisterPage(),
//     ),
//     GoRoute(
//       path: '/profile',
//       builder: (context, state) => BlocProvider(
//           create: (BuildContext context) => sl<ProfileCubit>()..getProfileDataMethod(),
//           child: const ProfilePage()),
//     ),
//     GoRoute(
//       path: '/todos',
//       builder: (context, state) => const TodoListPage(),
//     ),
//     GoRoute(
//       path: '/addTodo',
//       builder: (context, state) => const AddTodoPage(),
//     ),
//     GoRoute(
//       path: '/todo/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return TodoDetailsPage(id: id);
//       },
//     ),
//     GoRoute(
//       path: '/qrScanner',
//       builder: (context, state) => QRScannerPage(),
//     ),
//   ],
// );
