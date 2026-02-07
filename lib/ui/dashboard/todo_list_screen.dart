import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:todo_application/app_routers/navigator_const.dart';
import 'package:todo_application/config/app_config.dart';
import 'package:todo_application/const/app_style_constant.dart';
import 'package:todo_application/db/todo_local_service.dart';
import 'package:todo_application/features/presentation/bloc/todo_bloc.dart';
import 'package:todo_application/features/presentation/model/todo_model/todo_list_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: const TodoListScreen(),
    );
  }

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoData> todoList = [];
  int deleteIndex = -1;

  @override
  void initState() {
    super.initState();
    loadLocalTodos();
    _getTodoList();
  }

  Future<void> loadLocalTodos() async {
    final data = await TodoLocalService.getTodos();
    setState(() {
      todoList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo - ${AppConfig.environment.name.toUpperCase()}"),actions: [
        IconButton(
          icon: const Icon(Icons.add_card),
          onPressed: () async{
            final result = await  Navigator.pushNamed(
                context,
                NavigatorConst.editAddTodoScreen,
                arguments: {
                  "todo" : null
                }
            );
            if (result != null) {
              setState(() {
                todoList.add(result as TodoData);
              });
              todoList.sort((a, b) => b.todoId!.compareTo(a.todoId ?? 0));
            }

          },
        ),
      ],),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.isCompleted) {
            if (state.todoListModel != null) {
              todoList = state.todoListModel?.data ?? [];
            }
            if(state.deleteTodoModel != null) {
              todoList.removeAt(deleteIndex);
              TodoLocalService.updateTodo(todoList[deleteIndex]);
              loadLocalTodos();
              deleteIndex = -1;

              Fluttertoast.showToast(msg: "Todo removed successfully",textColor: AppStyles.whiteColor,backgroundColor: AppStyles.greenColor);
            }
          } else if (state.error != null) {
            Fluttertoast.showToast(msg: state.error.toString());
          }
        },
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            return state.isGetLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: todoList.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),

                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(todoList[index].title ?? ""),
                          subtitle: Text(
                            todoList[index].completed == 1
                                ? "Completed"
                                : "Pending",
                            style: TextStyle(
                              color: todoList[index].completed == 1
                                  ? AppStyles.greenColor
                                  : AppStyles.orangeColor,
                            ),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async{
                                  final result = await  Navigator.pushNamed(
                                      context,
                                      NavigatorConst.editAddTodoScreen,
                                      arguments: {
                                        "todo" : todoList[index]
                                      }
                                  );
                                  if (result != null) {
                                    setState(() {
                                      todoList[index] = result as TodoData;
                                    });
                                    await TodoLocalService.updateTodo(result as TodoData);
                                    loadLocalTodos();
                                  }

                                },
                              ),
                              deleteIndex == index
                                  ? CircularProgressIndicator(
                                      color: AppStyles.primaryColor,
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          deleteIndex = index;
                                        });

                                        _deleteTodoList(todoList[index].todoId);
                                      },
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  Future<void> _getTodoList() async {
    try {
      BlocProvider.of<TodoBloc>(context).add(PerformGetTodoListEvent());
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  Future<void> _deleteTodoList(todoID) async {
    try {
      BlocProvider.of<TodoBloc>(
        context,
      ).add(PerformDeleteTodoEvent(todoId: todoID));
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
