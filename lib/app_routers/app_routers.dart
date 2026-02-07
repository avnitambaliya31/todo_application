import 'package:flutter/material.dart';
import 'package:todo_application/app_routers/navigator_const.dart';
import 'package:todo_application/ui/dashboard/add_edit_todo_screen.dart';
import 'package:todo_application/ui/splash_screen.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigatorConst.splashScreen:
        return _buildRoute(settings, SplashScreen());
      case NavigatorConst.editAddTodoScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, AddEditTodoScreen(todo: arguments['todo'],));

      default:
        return _buildRoute(settings, Container());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return CustomMaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(builder: builder, settings: settings);
}
