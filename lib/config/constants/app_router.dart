import 'package:go_router/go_router.dart';
import 'package:tasky/storage.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/todo/presentation/pages/add_todo_page.dart';
import '../../features/todo/presentation/pages/qr_scanner_page.dart';
import '../../features/todo/presentation/pages/todo_details_page.dart';
import '../../features/todo/presentation/pages/todo_list_page.dart';

final GoRouter router = GoRouter(
  initialLocation:
  AppSharedPreferences.sharedPreferences.getString("accessToken") != null
      ? "/todos"
      : "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) =>  const RegisterPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodoListPage(),
    ),
    GoRoute(
      path: '/addTodo',
      builder: (context, state) => const AddTodoPage(),
    ),
    GoRoute(
      path: '/todo/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TodoDetailsPage(id: id);
      },
    ),
    GoRoute(
      path: '/qrScanner',
      builder: (context, state) =>  QRScannerPage(),
    ),
  ],
);
