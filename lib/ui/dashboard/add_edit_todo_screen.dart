import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:todo_application/const/app_style_constant.dart';
import 'package:todo_application/features/presentation/model/todo_model/delete_todo_model.dart';
import 'package:todo_application/features/presentation/model/todo_model/todo_list_model.dart';
import 'package:todo_application/features/presentation/repository/todo_repo/todo_repository_impl.dart';

import '../../features/presentation/bloc/todo_bloc.dart';

class AddEditTodoScreen extends StatefulWidget {
  final TodoData? todo;

  const AddEditTodoScreen({super.key, this.todo});

  static Widget create() {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: const AddEditTodoScreen(),
    );
  }

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final repo = TodoRepositoryImpl();
  final titleController = TextEditingController();
  int completed = 0;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo?.title ?? "";
      completed = widget.todo?.completed ?? 0;
    }
  }

  // Future<void> submit() async {
  //   if (widget.todo == null) {
  //     // ADD
  //     await repo.addTodoAPI(
  //       title: titleController.text,
  //       completed: completed,
  //     );
  //   } else {
  //     // UPDATE
  //     await repo.updateTodoAPI(
  //       id: widget.todo?.todoId ?? 1,
  //       title: titleController.text,
  //       completed: completed,
  //     );
  //   }
  //
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? "Add Todo" : "Edit Todo"),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.isCompleted) {
            if (state.updateTodoModel != null) {
              Fluttertoast.showToast(
                msg: "Todo updated successfully",
                textColor: AppStyles.whiteColor,
                backgroundColor: AppStyles.greenColor,
              );
              final todoList = TodoData(
                todoId: widget.todo?.todoId,
                title: titleController.text,
                completed: completed ,
              );
              Navigator.of(context).pop(todoList);
            }
            if(state.addTodoListModel != null) {
              Fluttertoast.showToast(
                msg: "Todo Added successfully",
                textColor: AppStyles.whiteColor,
                backgroundColor: AppStyles.greenColor,
              );
              final todoList = TodoData(
                todoId:state.addTodoListModel?.id ?? 0,
                title: titleController.text,
                completed: completed ,
              );
              Navigator.of(context).pop(todoList);
            }
          } else if (state.error != null) {
            Fluttertoast.showToast(msg: state.error.toString());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: completed == 0 ? false : true,
                    title: const Text("Completed"),
                    onChanged: (v) => setState(() {
                      if(v == true){
                        completed =1;
                      }else {
                        completed = 0;
                      }
                    } ),
                  ),
                  const SizedBox(height: 20),
                  state.isUpdateLoading || state.isAddLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (widget.todo == null) {
                              _addTodoList();
                            } else {
                              _updateTodoList();
                            }
                          },
                          child: const Text("Save"),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _updateTodoList() async {
    try {
      BlocProvider.of<TodoBloc>(context).add(
        PerformUpdateTodoEvent(
          bodyData: {
            "id": widget.todo?.todoId ?? 1,
            "title": titleController.text,
            "completed": completed == 1 ? true : false,
          },
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  Future<void> _addTodoList() async {
    try {
      BlocProvider.of<TodoBloc>(context).add(
        PerformAddTodoEvent(
          bodyData: {
            "title": titleController.text,
            "completed": completed == 1 ? true : false,
          },
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
