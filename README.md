# todo_application

A new Flutter project version is Flutter 3.35.7 • channel stable.

## Getting Started

# Flutter Todo Application

This Flutter application is built using a modular, scalable architecture and supports multiple environments using Flutter flavors such as Development, QA, Staging, and Production.

---

## 📂 Project Structure

```text
lib/
 ├── main.dart
 ├── main_dev.dart
 ├── main_qa.dart
 ├── main_staging.dart
 ├── main_prod.dart
 │
 ├── ui/
 │   ├── my_app.dart
 │   ├── splash_screen.dart
 │   ├── block_app/
 │   │   └── block_app_screen.dart
 │   ├── crash/
 │   │   ├── crash_page.dart
 │   │   └── restrat_widget.dart
 │   └── dashboard/
 │       ├── add_edit_todo_screen.dart
 │       └── todo_list_screen.dart
 │
 ├── config/
 │   ├── app_config.dart
 │   └── flavor.dart
 │
 ├── security/
 │   └── root_check.dart
 │
 ├── app_routers/
 │   ├── app_routers.dart
 │   └── navigator_const.dart
 │
 ├── features/
 │   ├── api_client/
 │   │   ├── dio_client.dart
 │   │   └── api_base_helper.dart
 │   │
 │   └── presentation/
 │       ├── bloc/
 │       │   ├── todo_bloc.dart
 │       │   ├── todo_event.dart
 │       │   └── todo_state.dart
 │       │
 │       ├── repository/
 │       │   └── todo_repo/
 │       │       ├── todo_repository.dart
 │       │       └── todo_repository_impl.dart
 │       │
 │       └── model/
 │           ├── todo_model/
 │           │   ├── todo_list_model.dart
 │           │   └── delete_todo_model.dart
 │           └── api_models/
 │               ├── api_response.dart
 │               ├── api_status.dart
 │               ├── api_error.dart
 │               ├── error_dto.dart
 │               └── *.g.dart
 │
 ├── db/
 │   ├── database_helper.dart
 │   └── todo_local_service.dart
 │
 ├── utils/
 │   └── app_dependencies.dart
 │
 └── const/
     ├── app_constants.dart
     ├── app_style_constant.dart
     └── image_const.dart

Run App with Flavor :-
1. flutter run --flavor dev -t lib/main_dev.dart
2. flutter run --flavor qa -t lib/main_qa.dart
3. flutter run --flavor prod -t lib/main_prod.dart
4. flutter run --flavor stag -t lib/main_stag.dart


