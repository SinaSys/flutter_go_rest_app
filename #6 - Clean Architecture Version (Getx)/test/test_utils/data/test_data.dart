import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';

const int tDummyId = 1;
const String tDummyName = 'dummy name';
const String tDummyBody = 'dummy body';
const String tDummyEmail = "dummyEmail@email.com";
const String tDummyDate = "2023-12-11T00:00:00.000+05:30";
const String tDummyExceptionMsg = "dummy Exception message";

const String tUserDummyUrl = "${ApiConfig.users}/$tDummyId";
const String tTodoDummyUrl = "${ApiConfig.todos}/$tDummyId";
const String tPostDummyUrl = "${ApiConfig.posts}/$tDummyId";
const String tCommentDummyUrl = "${ApiConfig.comments}/$tDummyId";

const User tUserDummyObject = User(
  id: tDummyId,
  name: tDummyName,
  email: tDummyEmail,
  gender: Gender.male,
  status: UserStatus.inactive,
);

final ToDo tTodoDummyObject = ToDo(
  id: tDummyId,
  userId: tDummyId,
  title: tDummyName,
  dueOn: DateTime.parse(tDummyDate),
  status: TodoStatus.pending,
);

const Post tPostDummyObject = Post(
  id: tDummyId,
  userId: tDummyId,
  title: tDummyName,
  body: tDummyBody,
);

const Comment tCommentDummyObject = Comment(
  id: tDummyId,
  postId: tDummyId,
  name: tDummyName,
  email: tDummyEmail,
  body: tDummyBody,
);
