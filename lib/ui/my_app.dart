import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/app_routers/app_routers.dart';
import 'package:todo_application/features/presentation/bloc/todo_bloc.dart';
import 'package:todo_application/ui/crash/crash_page.dart';
import 'package:todo_application/ui/dashboard/todo_list_screen.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Global crash fallback
    ErrorWidget.builder = (details) {
      return  CrashScreen(message: details.toString());
    };

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (_) => TodoBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: TodoListScreen.create(),
        onGenerateRoute: _router.getRoute,
        navigatorObservers: [_router.routeObserver],
      ),
    );
  }
}
