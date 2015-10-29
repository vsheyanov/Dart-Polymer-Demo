library demo.wrike.model.vo.task;

import 'package:polymer/polymer_micro.dart';
import 'package:polymer/polymer.dart';

import 'package:wrike_demo/model/vo/user.dart';

import 'dart:convert' show JSON;

class Task extends Object with JsProxy{
  @reflectable
  String id;

  @reflectable
  List<User> assignee;

  Task (this.id, this.assignee);

  Task.fromJson(obj){
    if (obj == null)
      return;

    id = obj['id'];
    assignee = new List<User>();
    obj['assignee'].forEach((userObj) => assignee.add(new User.fromJson(userObj)));
  }

  //TODO automate
  Map toJson() => {
    'id' : id,
    'assignee' : assignee
  };
}