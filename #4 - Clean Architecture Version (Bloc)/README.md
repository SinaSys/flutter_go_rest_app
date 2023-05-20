# 🔥 Go Rest app

![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/go_rest.jpg?raw=true)


In this project, we are going to build a user management app using Flutter. We have used the [Go REST](https://gorest.co.in/) API to make HTTP request methods. This API provides all sorts of methods that we need: GET, POST, PUT, and DELETE. We will call all endpoints (users/todos/posts/comments) provided to us by the Go REST API using the Dio package in our app. We have performed different operations like selecting, adding, editing, and removing users, as well as user posts, todos, and comments.
<br/><br/><br/>



## 🖼 Screenshots
User screen                |  Create-update User       |        Todo screen        |   Post screen
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/user_list_screen.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/create_user_dialog.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/todo_screen.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/post_list_screen.png?raw=true)



Date picker                    |   Time picker             |  Create-update post    |  Comment Screen
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/date_picker.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/time_picker.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/create_update_post_screen.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/post_detail_screen.png?raw=true)



Error state                    |   Empty state             |  Warning dialog    |  Progress dialog
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/error_state.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/empty_state.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/warning_dialog.png?raw=true)|![](https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/progress_dialog.png?raw=true)
<br/>


## 🧩 Entity Relationship Diagram (ERD)
<p align="center">
  <img src="https://github.com/SinaSys/flutter_go_rest_app/blob/master/screenshots/erd.png?raw=true">
</p>



## 🚀 Features
+ Different implementations with separate modules based on state management solutions and software architectures
+ Clean architecture / MVVM architecture / simple layered architecture
+ Feature-first and Layer-first approach
+ Performing CRUD operation using ```Dio``` and go rest api
+ Converting JSON string to an equivalent dart object and vice versa with ```json serializable```
+ Implementing Interceptors, Global configuration and timeout for api calls
+ Exception Handling with Dio interceptor, ```Dartz``` and ```freezed```
+ Dependency injection with ```get it```  (Clean architecture / MVVM architecture version)
+ Displaying error type to the user through the alert dialogs
+ Colorize api info like request, response, body and exceptions in Debug console log
+ Read, create, update and delete user
+ Filter users by status activity or gender
+ Read, create, update and delete user todos
+ Filter todos by status
+ Read, create, update and delete user posts
+ Display, create and delete user comments for each post
+ Get date/time from user by Date/Time picker
+ Generic structure
+ State management with ```GetX``` | ```Bloc``` | ```Cubit``` | ```RxDart```

  <br/>


## 🤝 Feature-first and Layer-first
In this repository two architectural approaches have been used.
Feature-first (for clean architecture and simple layered architecture version)
and Layer-first (for mvvm architecture version).

The feature-first approach demands that we create a new folder for every new feature that we add to our app.
And inside that, we add the layers themselves as sub-folders. But in Layer-first approach, we add all the relevant
files inside each feature folder, ensuring that they belong to the correct layer.

  <br/>

## ❗️ Api limitation


• The user endpoint contains ten user objects by default. If any of them are deleted, they will be replaced with a new JSON object. This means that the length of the user list will always be ten, and it is not possible to create more than ten user objects. This also applies if you want to add query parameters to the users.

• To use the request methods PUT, POST, PATCH, and DELETE, you need to provide an access token. This token must be passed with the "Authorization" header as a Bearer token. I have already included my own token in the app. However, if you receive an Unauthorized Error (401), please go to this [link](https://gorest.co.in/consumer/login) to obtain a new token and replace the old token in the api_config file located in the core directory.

• Please note that the data is not permanent and will be changed or deleted every 20 minutes to 1 hour.
<br/><br/><br/>


## 🗂 Modules
|               Version                |                                                           Bloc                                                            |                                                                                                         Cubit                                                                                                          |                                                           Getx                                                            |                                                            RxDart + Provider                                                             |
|:------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------:|
|      Clean architecture version      | [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%234%20-%20Clean%20Architecture%20Version%20(Bloc))️  |                                                [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%235%20-%20Clean%20Architecture%20Version%20(Cubit))                                                |  [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%236%20-%20Clean%20Architecture%20Version%20(Getx))  | [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%2310%20-%20Clean%20Architecture%20Version%20(RxDart%20%2B%20Provider)) |
| MVVM  architecture version           |   [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%237%20-%20MVVM%20Version%20(Bloc))|  [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%238%20-%20MVVM%20Version%20(Cubit))️                                                       |                                                        [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%239%20-%20MVVM%20Version%20(GetX))️                                                        |
| Simple layered architecture version | [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%233%20-%20Layered%20Architecture%20Version%20(Bloc)) |                                               [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%232%20-%20Layered%20Architecture%20Version%20(Cubit))                                               | [Source](https://github.com/SinaSys/flutter_go_rest_app/tree/master/%231%20-%20Layered%20Architecture%20Version%20(GetX)) |

  <br/>

## 📚 Dependencies (Clean architecture version (Feature-first))
|                               Name                                |  GetX |  Cubit |  Bloc |   RxDart + Provider   |
|:-----------------------------------------------------------------:|:-------------------------------------------------------:|:--------------------------------------------------------:|:--------------------------------------------------------:|:--------------------------------------------------------:|
|       [flutter_bloc](https://pub.dev/packages/flutter_bloc)       |✖️ | ✔  | ✔  |✖  |
|          [provider ](https://pub.dev/packages/provider)           |✖️ | ✖  | ✖  |✔  |
|             [rxdart](https://pub.dev/packages/rxdart)             |✖️ | ✖  | ✖  |✔  |
|             [get_it](https://pub.dev/packages/get_it)             |✔️ | ✔  | ✔  | ✔  |
|               [GetX](https://pub.dev/packages/get)                |✔️ | ✖️ | ✖️ | ✖  |
|                [dio](https://pub.dev/packages/dio)                |✔️ | ✔️ | ✔️ | ✔  |
|            [freezed](https://pub.dev/packages/freezed)            |✖️ | ✔️ | ✔️ | ✔  |
| [freezed_annotation](https://pub.dev/packages/freezed_annotation) |✖ | ✔️ | ✔️ | ✔  |
|    [json_annotation](https://pub.dev/packages/json_annotation)    |✔️ | ✔️ | ✔️ | ✔  |
|  [json_serializable](https://pub.dev/packages/json_serializable)  |✔️ | ✔️ | ✔️ |✔  |
|       [build_runner](https://pub.dev/packages/build_runner)       |✔️ | ✔️ | ✔️ | ✔  |
|             [logger](https://pub.dev/packages/logger)             |✔️ | ✔️ | ✔️ | ✔  |
|              [dartz](https://pub.dev/packages/dartz)              |✔️ | ✖️ | ✖️ | ✖  |
|    [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)    |✔️ | ✔️ | ✔️ |✔  |
|               [intl](https://pub.dev/packages/intl)               |✔️ | ✔️ | ✔️ |✔  |

  <br/>

  <br/>

## 📚 Dependencies (MVVM architecture version (Layer-first))
|       Name      |  GetX |  Cubit |  Bloc |
| :-------------: |:-------------------------------------------------------:|:--------------------------------------------------------:|:--------------------------------------------------------:|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)  |✖️ | ✔  | ✔  |
| [get_it](https://pub.dev/packages/get_it)  |✔️ | ✔  | ✔  | 
| [GetX](https://pub.dev/packages/get)  |✔️ | ✖️ | ✖️ | 
| [dio](https://pub.dev/packages/dio)  |✔️ | ✔️ | ✔️ | 
| [freezed](https://pub.dev/packages/freezed)  |✖️ | ✔️ | ✔️ | 
| [freezed_annotation](https://pub.dev/packages/freezed_annotation)  |✖ | ✔️ | ✔️ | 
| [json_annotation](https://pub.dev/packages/json_annotation)  |✔️ | ✔️ | ✔️ | 
| [json_serializable](https://pub.dev/packages/json_serializable)  |✔️ | ✔️ | ✔️ |
| [build_runner](https://pub.dev/packages/build_runner)  |✔️ | ✔️ | ✔️ | 
| [logger](https://pub.dev/packages/logger)  |✔️ | ✔️ | ✔️ | 
| [dartz](https://pub.dev/packages/dartz)  |✔️ | ✖️ | ✖️ | 
| [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)  |✔️ | ✔️ | ✔️ |
| [intl](https://pub.dev/packages/intl)  |✔️ | ✔️ | ✔️ |

  <br/>

## 📚 Dependencies (Simple layered architecture version (Feature-first))
|       Name      |  GetX |  Cubit |  Bloc |
| :-------------: |:-------------------------------------------------------:|:--------------------------------------------------------:|:--------------------------------------------------------:|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)  |✖️ | ✔  | ✔  |
| [GetX](https://pub.dev/packages/get)  |✔️ | ✖️ | ✖️ | 
| [dio](https://pub.dev/packages/dio)  |✔️ | ✔️ | ✔️ | 
| [freezed](https://pub.dev/packages/freezed)  |✖️ | ✔️ | ✔️ | 
| [freezed_annotation](https://pub.dev/packages/freezed_annotation)  |✖ | ✔️ | ✔️ | 
| [json_annotation](https://pub.dev/packages/json_annotation)  |✔️ | ✔️ | ✔️ | 
| [json_serializable](https://pub.dev/packages/json_serializable)  |✔️ | ✔️ | ✔️ |
| [build_runner](https://pub.dev/packages/build_runner)  |✔️ | ✔️ | ✔️ | 
| [logger](https://pub.dev/packages/logger)  |✔️ | ✔️ | ✔️ | 
| [dartz](https://pub.dev/packages/dartz)  |✔️ | ✖️ | ✖️ | 
| [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)  |✔️ | ✔️ | ✔️ |
| [intl](https://pub.dev/packages/intl)  |✔️ | ✔️ | ✔️ |

  <br/>





<br/><br/>
## 📂 Directory Structure (Clean architecture version + Bloc)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂bloc
│   │   │──bloc_helper.dart
│   │   └──generic_bloc_state.dart
│   │───📂usecase
│   │   └──usecase.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_config.dart
│   │   │──api_helper.dart
│   │   │──api_result.dart
│   │   │──api_result.freezed.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
└───📂features
    │───📂user
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──user_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──user.dart
    │    │   │   └──user.g.dart
    │    │   └──📂repositories
    │    │       └──user_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──user_entity.dart
    │    │   │───📂repositories
    │    │   │   └──user_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_user_usecase.dart
    │    │   │   │──delete_user_usecase.dart
    │    │   │   │──get_users_usecase.dart
    │    │   │   └──update_user_usecase.dart
    │    └── 📂presentation
    │        │───📂bloc
    │        │   │──user_bloc.dart
    │        │   └──user_event.dart
    │        │───📂screens
    │        │   └──user_list_screen.dart
    │        └───📂widgets
    │            └──status_container.dart
    │
    │───📂todo
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──todo_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──todo.dart
    │    │   │   └──todo.g.dart
    │    │   └──📂repositories
    │    │       └──todo_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──todo_entity.dart
    │    │   │───📂repositories
    │    │   │   └──todo_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_todo_usecase.dart
    │    │   │   │──delete_todo_usecase.dart
    │    │   │   │──get_todos_usecase.dart
    │    │   │   └──update_todo_usecase.dart
    │    └── 📂presentation
    │        │───📂bloc
    │        │   │──todo_bloc.dart
    │        │   └──todo_event.dart
    │        │───📂screens
    │        │   └──todo_list_screen.dart
    │        └───📂widgets
    │            │──circle_container.dart
    │            └──todo_list_item.dart
    │───📂post
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──post_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──post.dart
    │    │   │   └──post.g.dart
    │    │   └──📂repositories
    │    │       └──post_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──post_entity.dart
    │    │   │───📂repositories
    │    │   │   └──post_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_post_usecase.dart
    │    │   │   │──delete_post_usecase.dart
    │    │   │   │──get_posts_usecase.dart
    │    │   │   └──update_post_usecase.dart
    │    └── 📂presentation
    │        │───📂bloc
    │        │   │──post_bloc.dart
    │        │   └──post_event.dart
    │        └───📂screens
    │            │──create_post_screen.dart
    │            │──post_detail_screen.dart
    │            └──post_list_screen.dart
    └───📂comment
         │───📂data
         │   │──📂datasources
         │   │  └──comment_remote_data_source.dart
         │   │──📂models
         │   │   │──comment.dart
         │   │   └──comment.g.dart
         │   └──📂repositories
         │       └──comment_repository_impl.dart
         │───📂domain
         │   │───📂entities
         │   │   └──comment_entity.dart
         │   │───📂repositories
         │   │   └──comment_repository.dart
         │   │───📂usecases
         │   │   │──create_comment_usecase.dart
         │   │   │──delete_comment_usecase.dart
         │   │   └──get_comments_usecase.dart
         └── 📂presentation
             └───📂bloc
                 │──comment_bloc.dart
                 └──comment_event.dart


```



<br/><br/>
## 📂 Directory Structure (Clean architecture version + Cubit)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂cubit
│   │   │──generic_cubit.dart
│   │   └──generic_cubit_state.dart
│   │───📂usecase
│   │   └──usecase.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_config.dart
│   │   │──api_helper.dart
│   │   │──api_result.dart
│   │   │──api_result.freezed.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
└───📂features
    │───📂user
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──user_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──user.dart
    │    │   │   └──user.g.dart
    │    │   └──📂repositories
    │    │       └──user_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──user_entity.dart
    │    │   │───📂repositories
    │    │   │   └──user_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_user_usecase.dart
    │    │   │   │──delete_user_usecase.dart
    │    │   │   │──get_users_usecase.dart
    │    │   │   └──update_user_usecase.dart
    │    └── 📂presentation
    │        │───📂cubit
    │        │   └──user_cubit.dart
    │        │───📂screens
    │        │   └──user_list_screen.dart
    │        └───📂widgets
    │            └──status_container.dart
    │
    │───📂todo
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──todo_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──todo.dart
    │    │   │   └──todo.g.dart
    │    │   └──📂repositories
    │    │       └──todo_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──todo_entity.dart
    │    │   │───📂repositories
    │    │   │   └──todo_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_todo_usecase.dart
    │    │   │   │──delete_todo_usecase.dart
    │    │   │   │──get_todos_usecase.dart
    │    │   │   └──update_todo_usecase.dart
    │    └── 📂presentation
    │        │───📂cubit
    │        │   └──todo_cubit.dart
    │        │───📂screens
    │        │   └──todo_list_screen.dart
    │        └───📂widgets
    │            │──circle_container.dart
    │            └──todo_list_item.dart
    │───📂post
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──post_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──post.dart
    │    │   │   └──post.g.dart
    │    │   └──📂repositories
    │    │       └──post_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──post_entity.dart
    │    │   │───📂repositories
    │    │   │   └──post_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_post_usecase.dart
    │    │   │   │──delete_post_usecase.dart
    │    │   │   │──get_posts_usecase.dart
    │    │   │   └──update_post_usecase.dart
    │    └── 📂presentation
    │        │───📂cubit
    │        │   └──post_cubit.dart
    │        └───📂screens
    │            │──create_post_screen.dart
    │            │──post_detail_screen.dart
    │            └──post_list_screen.dart
    └───📂comment
         │───📂data
         │   │──📂datasources
         │   │  └──comment_remote_data_source.dart
         │   │──📂models
         │   │   │──comment.dart
         │   │   └──comment.g.dart
         │   └──📂repositories
         │       └──comment_repository_impl.dart
         │───📂domain
         │   │───📂entities
         │   │   └──comment_entity.dart
         │   │───📂repositories
         │   │   └──comment_repository.dart
         │   │───📂usecases
         │   │   │──create_comment_usecase.dart
         │   │   │──delete_comment_usecase.dart
         │   │   └──get_comments_usecase.dart
         └── 📂presentation
             └───📂cubit
                 └──comment_cubit.dart


```


<br/><br/>
## 📂 Directory Structure (Clean architecture version + RxDart + Provider)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂bloc
│   │   └──generic_bloc_state.dart
│   │───📂usecase
│   │   └──usecase.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_config.dart
│   │   │──api_helper.dart
│   │   │──api_result.dart
│   │   │──api_result.freezed.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
└───📂features
    │───📂user
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──user_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──user.dart
    │    │   │   └──user.g.dart
    │    │   └──📂repositories
    │    │       └──user_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──user_entity.dart
    │    │   │───📂repositories
    │    │   │   └──user_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_user_usecase.dart
    │    │   │   │──delete_user_usecase.dart
    │    │   │   │──get_users_usecase.dart
    │    │   │   └──update_user_usecase.dart
    │    └── 📂presentation
    │        │───📂bloc
    │        │   │──user_bloc.dart
    │        │   └──user_event.dart
    │        │───📂screens
    │        │   └──user_list_screen.dart
    │        └───📂widgets
    │            └──status_container.dart
    │
    │───📂todo
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──todo_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──todo.dart
    │    │   │   └──todo.g.dart
    │    │   └──📂repositories
    │    │       └──todo_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──todo_entity.dart
    │    │   │───📂repositories
    │    │   │   └──todo_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_todo_usecase.dart
    │    │   │   │──delete_todo_usecase.dart
    │    │   │   │──get_todos_usecase.dart
    │    │   │   └──update_todo_usecase.dart
    │    └── 📂presentation
    │        │───📂bloc
    │        │   │──todo_bloc.dart
    │        │   └──todo_event.dart
    │        │───📂screens
    │        │   └──todo_list_screen.dart
    │        └───📂widgets
    │            │──circle_container.dart
    │            └──todo_list_item.dart
    │───📂post
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──post_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──post.dart
    │    │   │   └──post.g.dart
    │    │   └──📂repositories
    │    │       └──post_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──post_entity.dart
    │    │   │───📂repositories
    │    │   │   └──post_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_post_usecase.dart
    │    │   │   │──delete_post_usecase.dart
    │    │   │   │──get_posts_usecase.dart
    │    │   │   └──update_post_usecase.dart
    │    └── 📂presentation
    │        │───📂bloc
    │        │   └──post_bloc.dart
    │        └───📂screens
    │            │──create_post_screen.dart
    │            │──post_detail_screen.dart
    │            └──post_list_screen.dart
    └───📂comment
         │───📂data
         │   │──📂datasources
         │   │  └──comment_remote_data_source.dart
         │   │──📂models
         │   │   │──comment.dart
         │   │   └──comment.g.dart
         │   └──📂repositories
         │       └──comment_repository_impl.dart
         │───📂domain
         │   │───📂entities
         │   │   └──comment_entity.dart
         │   │───📂repositories
         │   │   └──comment_repository.dart
         │   │───📂usecases
         │   │   │──create_comment_usecase.dart
         │   │   │──delete_comment_usecase.dart
         │   │   └──get_comments_usecase.dart
         └── 📂presentation
             └───📂bloc
                 └──comment_bloc.dart


```


<br/><br/>
## 📂 Directory Structure (Clean architecture version + GetX)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂controller
│   │   └──base_controller.dart
│   │───📂usecase
│   │   └──usecase.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_config.dart
│   │   │──api_base.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
└───📂features
    │───📂user
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──user_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──user.dart
    │    │   │   └──user.g.dart
    │    │   └──📂repositories
    │    │       └──user_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──user_entity.dart
    │    │   │───📂repositories
    │    │   │   └──user_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_user_usecase.dart
    │    │   │   │──delete_user_usecase.dart
    │    │   │   │──get_users_usecase.dart
    │    │   │   └──update_user_usecase.dart
    │    └── 📂presentation
    │        │───📂controller
    │        │   └──user_controller.dart
    │        │───📂screens
    │        │   └──user_list_screen.dart
    │        └───📂widgets
    │            └──status_container.dart
    │
    │───📂todo
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──todo_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──todo.dart
    │    │   │   └──todo.g.dart
    │    │   └──📂repositories
    │    │       └──todo_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──todo_entity.dart
    │    │   │───📂repositories
    │    │   │   └──todo_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_todo_usecase.dart
    │    │   │   │──delete_todo_usecase.dart
    │    │   │   │──get_todos_usecase.dart
    │    │   │   └──update_todo_usecase.dart
    │    └── 📂presentation
    │        │───📂controller
    │        │   └──todo_controller.dart
    │        │───📂screens
    │        │   └──todo_list_screen.dart
    │        └───📂widgets
    │            │──circle_container.dart
    │            └──todo_list_item.dart
    │───📂post
    │    │───📂data
    │    │   │──📂datasources
    │    │   │  └──post_remote_data_source.dart
    │    │   │──📂models
    │    │   │   │──post.dart
    │    │   │   └──post.g.dart
    │    │   └──📂repositories
    │    │       └──post_repository_impl.dart
    │    │───📂domain
    │    │   │───📂entities
    │    │   │   └──post_entity.dart
    │    │   │───📂repositories
    │    │   │   └──post_repository.dart
    │    │   │───📂usecases
    │    │   │   │──create_post_usecase.dart
    │    │   │   │──delete_post_usecase.dart
    │    │   │   │──get_posts_usecase.dart
    │    │   │   └──update_post_usecase.dart
    │    └── 📂presentation
    │        │───📂controller
    │        │   └──post_controller.dart
    │        └───📂screens
    │            │──create_post_screen.dart
    │            │──post_detail_screen.dart
    │            └──post_list_screen.dart
    └───📂comment
         │───📂data
         │   │──📂datasources
         │   │  └──comment_remote_data_source.dart
         │   │──📂models
         │   │   │──comment.dart
         │   │   └──comment.g.dart
         │   └──📂repositories
         │       └──comment_repository_impl.dart
         │───📂domain
         │   │───📂entities
         │   │   └──comment_entity.dart
         │   │───📂repositories
         │   │   └──comment_repository.dart
         │   │───📂usecases
         │   │   │──create_comment_usecase.dart
         │   │   │──delete_comment_usecase.dart
         │   │   └──get_comments_usecase.dart
         └── 📂presentation
             └───📂controller
                 └──comment_controller.dart


```


<br/><br/>
## 📂 Directory Structure (MVVM architecture version + Bloc)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂bloc
│   │   │──bloc_helper.dart
│   │   └──generic_bloc_state.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_helper.dart
│   │   │──api_result.dart
│   │   │──api_result.freezed.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──api_config.dart
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
│───📂data
│   │───📂api
│   │    │───📂comment
│   │    │   └──comment_api.dart
│   │    │───📂post
│   │    │   └──post_api.dart
│   │    │───📂todo
│   │    │   └──todo_api.dart
│   │    └───📂user
│   │        └──user_api.dart
│   │    
│   └───📂model 
│        │───📂comment
│        │   │──comment.dart
│        │   └──comment.g.dart
│        │───📂post
│        │   │──post.dart
│        │   └──post.g.dart
│        │───📂todo
│        │   │──todo.dart
│        │   └──todo.g.dart
│        └───📂user
│            │──user.dart
│            └──user.g.dart 
│    
│───📂repository
│    │───📂comment
│    │   └──comment_repository.dart
│    │───📂post
│    │   └──post_repository.dart
│    │───📂todo
│    │   └──todo_repository.dart
│    └───📂user
│        └──user_repository.dart
│
│───📂view
│    │───📂post
│    │   └──📂screen
│    │      │──create_post_screen.dart
│    │      │──post_detail_screen.dart
│    │      └──post_list_screen.dart
│    │    
│    │───📂todo
│    │   │──📂screen
│    │   │  └──todo_list_screen.dart
│    │   └──📂widget
│    │      │──circle_container.dart
│    │      └──todo_list_item.dart
│    │
│    └───📂user
│        │──📂screen
│        │  └──user_list_screen.dart
│        └──📂widget
│           └──status_container.dart
│     
└───📂viewmodel
         │───📂comment
         │   └──📂bloc
         │      └──comment_bloc.dart
         │      └──comment_event.dart
         │───📂post
         │   └──📂bloc
         │      └──post_bloc.dart
         │      └──post_event.dart
         │───📂todo
         │   └──📂bloc
         │      │──todo_bloc.dart
         │      └──todo_event.dart
         └───📂user
             └──📂bloc
                │──user_bloc.dart
                └──user_event.dart


```


<br/><br/>
## 📂 Directory Structure (MVVM architecture version + Cubit)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂cubit
│   │   │──generic_cubit.dart
│   │   └──generic_cubit_state.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_helper.dart
│   │   │──api_result.dart
│   │   │──api_result.freezed.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──api_config.dart
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
│───📂data
│   │───📂api
│   │    │───📂comment
│   │    │   └──comment_api.dart
│   │    │───📂post
│   │    │   └──post_api.dart
│   │    │───📂todo
│   │    │   └──todo_api.dart
│   │    └───📂user
│   │        └──user_api.dart
│   │    
│   └───📂model 
│        │───📂comment
│        │   │──comment.dart
│        │   └──comment.g.dart
│        │───📂post
│        │   │──post.dart
│        │   └──post.g.dart
│        │───📂todo
│        │   │──todo.dart
│        │   └──todo.g.dart
│        └───📂user
│            │──user.dart
│            └──user.g.dart 
│    
│───📂repository
│    │───📂comment
│    │   └──comment_repository.dart
│    │───📂post
│    │   └──post_repository.dart
│    │───📂todo
│    │   └──todo_repository.dart
│    └───📂user
│        └──user_repository.dart
│
│───📂view
│    │───📂post
│    │   └──📂screen
│    │      │──create_post_screen.dart
│    │      │──post_detail_screen.dart
│    │      └──post_list_screen.dart
│    │    
│    │───📂todo
│    │   │──📂screen
│    │   │  └──todo_list_screen.dart
│    │   └──📂widget
│    │      │──circle_container.dart
│    │      └──todo_list_item.dart
│    │
│    └───📂user
│        │──📂screen
│        │  └──user_list_screen.dart
│        └──📂widget
│           └──status_container.dart
│     
└───📂viewmodel
         │───📂comment
         │   └──📂cubit
         │      └──comment_cubit.dart
         │───📂post
         │   └──📂cubit
         │      └──post_cubit.dart
         │───📂todo
         │   └──📂cubit
         │      └──todo_cubit.dart
         └───📂user
             └──📂cubit
                └──user_cubit.dart


```

<br/><br/>
## 📂 Directory Structure (MVVM architecture version + GetX)
```
📂lib
│───main.dart  
│───di.dart  
│───📂common  
│   │───📂controller
│   │   └──base_controller.dart
│   │───📂repository
│   │   └──repository_helper.dart
│   │───📂network
│   │   │──api_helper.dart
│   │   │──api_result.dart
│   │   │──api_result.freezed.dart
│   │   │──dio_client.dart
│   │   │──dio_exception.dart
│   │   └──dio_interceptor.dart
│   │───📂widget
│   │   │──date_time_picker.dart
│   │   │──drop_down.dart
│   │   │──empty_widget.dart
│   │   │──popup_menu.dart
│   │   │──spinkit_indicator.dart
│   │   └──text_input.dart
│   └───📂dialog
│       │──create_dialog.dart
│       │──delete_dialog.dart
│       │──progress_dialog.dart
│       └──retry_dialog.dart
│───📂core
│   │──api_config.dart
│   │──app_asset.dart
│   │──app_extension.dart
│   │──app_string.dart
│   │──app_style.dart
│   └──app_theme.dart
│
│───📂data
│   │───📂api
│   │    │───📂comment
│   │    │   └──comment_api.dart
│   │    │───📂post
│   │    │   └──post_api.dart
│   │    │───📂todo
│   │    │   └──todo_api.dart
│   │    └───📂user
│   │        └──user_api.dart
│   │    
│   └───📂model 
│        │───📂comment
│        │   │──comment.dart
│        │   └──comment.g.dart
│        │───📂post
│        │   │──post.dart
│        │   └──post.g.dart
│        │───📂todo
│        │   │──todo.dart
│        │   └──todo.g.dart
│        └───📂user
│            │──user.dart
│            └──user.g.dart 
│    
│───📂repository
│    │───📂comment
│    │   └──comment_repository.dart
│    │───📂post
│    │   └──post_repository.dart
│    │───📂todo
│    │   └──todo_repository.dart
│    └───📂user
│        └──user_repository.dart
│
│───📂view
│    │───📂post
│    │   └──📂screen
│    │      │──create_post_screen.dart
│    │      │──post_detail_screen.dart
│    │      └──post_list_screen.dart
│    │    
│    │───📂todo
│    │   │──📂screen
│    │   │  └──todo_list_screen.dart
│    │   └──📂widget
│    │      │──circle_container.dart
│    │      └──todo_list_item.dart
│    │
│    └───📂user
│        │──📂screen
│        │  └──user_list_screen.dart
│        └──📂widget
│           └──status_container.dart
│     
└───📂viewmodel
         │───📂comment
         │   └──📂controller
         │      └──comment_controller.dart
         │───📂post
         │   └──📂controller
         │      └──post_controller.dart
         │───📂todo
         │   └──📂controller
         │      └──todo_controller.dart
         └───📂user
             └──📂controller
                └──user_controller.dart


```



## 📂 Directory Structure (Simple layered architecture version + Cubit)

```
📂lib
 │───main.dart  
 │───📂common  
 │   │───📂cubit
 │   │   │──generic_cubit.dart
 │   │   └──generic_cubit_state.dart
 │   │───📂network
 │   │   │──api_base.dart
 │   │   │──api_result.dart
 │   │   │──api_result.freezed.dart
 │   │   │──dio_client.dart
 │   │   │──dio_exception.dart
 │   │   └──dio_interceptor.dart
 │   │───📂widget
 │   │   │──date_time_picker.dart
 │   │   │──drop_down.dart
 │   │   │──empty_widget.dart
 │   │   │──popup_menu.dart
 │   │   │──spinkit_indicator.dart
 │   │   └──text_input.dart 
 │   └───📂dialog
 │       │──create_dialog.dart
 │       │──delete_dialog.dart
 │       │──progress_dialog.dart
 │       └──retry_dialog.dart
 │───📂core 
 │   │──api_config.dart
 │   │──app_asset.dart
 │   │──app_extension.dart
 │   │──app_string.dart
 │   │──app_style.dart
 │   └──app_theme.dart
 └───📂features
     │───📂comment
     │    │───📂cubit
     │    │   └──comment_cubit.dart
     │    └───📂data
     │        │───📂model
     │        │   │──comment.dart
     │        │   └──comment.g.dart
     │        └───📂provider
     │            └──📂remote
     │               └──comment_api.dart
     │───📂post
     │    │───📂cubit
     │    │   └──post_cubit.dart
     │    │───📂data
     │    │   │───📂model
     │    │   │   │──post.dart
     │    │   │   └──post.g.dart
     │    │   └───📂provider
     │    │       └──📂remote
     │    │          └──psot_api.dart
     │    └───📂view  
     │        └──📂screen
     │           │──create_post_screen.dart
     │           │──post_detail_screen.dart
     │           └──post_list_screen.dart
     │───📂todo
     │    │───📂cubit
     │    │   └──todo_cubit.dart
     │    │───📂data
     │    │   │───📂model
     │    │   │   │──todo.dart
     │    │   │   └──todo.g.dart
     │    │   └───📂provider
     │    │       └──📂remote
     │    │          └──todo_api.dart
     │    └───📂view  
     │        │──📂screen
     │        │  └──todo_list_screen.dart
     │        └──📂widget
     │            │──circle_container.dart
     │            └──todo_list_item.dart
     └───📂user
          │───📂cubit
          │   └──user_cubit.dart
          │───📂data
          │   │───📂model
          │   │   │──user.dart
          │   │   └──user.g.dart
          │   └───📂provider
          │       └──📂remote
          │          └──user_api.dart
          └───📂view  
              │──📂screen
              │  └──user_list_screen.dart
              └──📂widget
                 └──status_container.dart

```



## 📂 Directory Structure (Simple layered architecture version + Bloc)

```
📂lib
 │───main.dart  
 │───📂common  
 │   │───📂bloc
 │   │   │──bloc_helper.dart
 │   │   └──generic_bloc_state.dart
 │   │───📂network
 │   │   │──api_base.dart
 │   │   │──api_result.dart
 │   │   │──api_result.freezed.dart
 │   │   │──dio_client.dart
 │   │   │──dio_exception.dart
 │   │   └──dio_interceptor.dart
 │   │───📂widget
 │   │   │──date_time_picker.dart
 │   │   │──drop_down.dart
 │   │   │──empty_widget.dart
 │   │   │──popup_menu.dart
 │   │   │──spinkit_indicator.dart
 │   │   └──text_input.dart 
 │   └───📂dialog
 │       │──create_dialog.dart
 │       │──delete_dialog.dart
 │       │──progress_dialog.dart
 │       └──retry_dialog.dart
 │───📂core 
 │   │──api_config.dart
 │   │──app_asset.dart
 │   │──app_extension.dart
 │   │──app_string.dart
 │   │──app_style.dart
 │   └──app_theme.dart
 └───📂features
     │───📂comment
     │    │───📂bloc
     │    │   │──comment_bloc.dart
     │    │   └──comment_event.dart
     │    └───📂data
     │        │───📂model
     │        │   │──comment.dart
     │        │   └──comment.g.dart
     │        └───📂provider
     │            └──📂remote
     │               └──comment_api.dart
     │───📂post
     │    │───📂bloc
     │    │   └──post_bloc.dart
     │    │   │──post_event.dart
     │    │───📂data
     │    │   │───📂model
     │    │   │   │──post.dart
     │    │   │   └──post.g.dart
     │    │   └───📂provider
     │    │       └──📂remote
     │    │          └──psot_api.dart
     │    └───📂view  
     │        └──📂screen
     │           │──create_post_screen.dart
     │           │──post_detail_screen.dart
     │           └──post_list_screen.dart
     │───📂todo
     │    │───📂bloc
     │    │   │──todo_bloc.dart
     │    │   └──todo_event.dart
     │    │───📂data
     │    │   │───📂model
     │    │   │   │──todo.dart
     │    │   │   └──todo.g.dart
     │    │   └───📂provider
     │    │       └──📂remote
     │    │          └──todo_api.dart
     │    └───📂view  
     │        │──📂screen
     │        │  └──todo_list_screen.dart
     │        └──📂widget
     │            │──circle_container.dart
     │            └──todo_list_item.dart
     └───📂user
          │───📂bloc
          │   │──user_bloc.dart
          │   └──user_event.dart
          │───📂data
          │   │───📂model
          │   │   │──user.dart
          │   │   └──user.g.dart
          │   └───📂provider
          │       └──📂remote
          │          └──user_api.dart
          └───📂view  
              │──📂screen
              │  └──user_list_screen.dart
              └──📂widget
                 └──status_container.dart

```



## 📂 Directory Structure (Simple layered architecture version + GetX)

```
📂lib
 │───main.dart  
 │───📂common  
 │   │───📂controller
 │   │   └──base_controller.dart
 │   │───📂network
 │   │   │──api_base.dart
 │   │   │──dio_client.dart
 │   │   │──dio_exception.dart
 │   │   └──dio_interceptor.dart
 │   │───📂widget
 │   │   │──date_time_picker.dart
 │   │   │──drop_down.dart
 │   │   │──empty_widget.dart
 │   │   │──popup_menu.dart
 │   │   │──spinkit_indicator.dart
 │   │   └──text_input.dart 
 │   └───📂dialog
 │       │──create_dialog.dart
 │       │──delete_dialog.dart
 │       │──progress_dialog.dart
 │       └──retry_dialog.dart
 │───📂core 
 │   │──api_config.dart
 │   │──app_asset.dart
 │   │──app_extension.dart
 │   │──app_string.dart
 │   │──app_style.dart
 │   └──app_theme.dart
 └───📂features
     │───📂comment
     │    │───📂controller
     │    │   └──comment_controller.dart
     │    └───📂data
     │        │───📂model
     │        │   │──comment.dart
     │        │   └──comment.g.dart
     │        └───📂provider
     │            └──📂remote
     │               └──comment_api.dart
     │───📂post
     │    │───📂controller
     │    │   └──post_controller.dart
     │    │───📂data
     │    │   │───📂model
     │    │   │   │──post.dart
     │    │   │   └──post.g.dart
     │    │   └───📂provider
     │    │       └──📂remote
     │    │          └──psot_api.dart
     │    └───📂view  
     │        └──📂screen
     │           │──create_post_screen.dart
     │           │──post_detail_screen.dart
     │           └──post_list_screen.dart
     │───📂todo
     │    │───📂controller
     │    │   └──todo_controller.dart
     │    │───📂data
     │    │   │───📂model
     │    │   │   │──todo.dart
     │    │   │   └──todo.g.dart
     │    │   └───📂provider
     │    │       └──📂remote
     │    │          └──todo_api.dart
     │    └───📂view  
     │        │──📂screen
     │        │  └──todo_list_screen.dart
     │        └──📂widget
     │            │──circle_container.dart
     │            └──todo_list_item.dart
     └───📂user
          │───📂controller
          │   └──user_controller.dart
          │───📂data
          │   │───📂model
          │   │   │──user.dart
          │   │   └──user.g.dart
          │   └───📂provider
          │       └──📂remote
          │          └──user_api.dart
          └───📂view  
              │──📂screen
              │  └──user_list_screen.dart
              └──📂widget
                 └──status_container.dart

```



<br/><br/>
## 🎯 Other flutter projects
Project Name        |Stars
:-------------------------|-------------------------
[Japanese restaurant app](https://github.com/SinaSys/flutter_japanese_restaurant_app)| ![GitHub stars](https://img.shields.io/github/stars/SinaSys/flutter_japanese_restaurant_app?style=social)
|[Office furniture store app](https://github.com/SinaSys/flutter_office_furniture_store_app) |![GitHub stars](https://img.shields.io/github/stars/SinaSys/flutter_office_furniture_store_app?style=social)
|[Ecommerce app](https://github.com/SinaSys/flutter_ecommerce_app)|![GitHub stars](https://img.shields.io/github/stars/SinaSys/flutter_ecommerce_app?style=social)





