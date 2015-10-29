library demo.wrike.model.vo.task;

import 'package:polymer/polymer_micro.dart';
import 'package:polymer/polymer.dart';

import 'package:wrike_demo/model/vo/user.dart';

class Task extends Object with JsProxy{
  @reflectable
  String id;

  @reflectable
  List<User> assignee;

  Task (this.id, this. assignee);
}