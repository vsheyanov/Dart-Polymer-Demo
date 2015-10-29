library demo.wrike.model.service.mockservice;

import 'dart:async';

import 'package:wrike_demo/model/vo/user.dart';
import 'package:wrike_demo/model/vo/task.dart';

class MockService {

  static final MockService _instance = new MockService._internal();

  MockService._internal (){
    initMockdata();
  }

  factory MockService(){
    return _instance;
  }

  Map<String, Task> _tasks = new Map();

  initMockdata () {
    _addMockTask(
      new Task("1",
        [
          new User("Victor", "Sheyanov"),
          new User("Victor", "Petrov"),
          new User("Victor", "Ivanov")
        ]
      )
    );

    _addMockTask(
        new Task("2",
            [
              new User("Ivan", "Petrov"),
              new User("Ivan", "Ivanov")
            ]
        )
    );

    _addMockTask(
        new Task("3",
            [
              new User("Petr", "Obama"),
              new User("Sasha", "Putin"),
              new User("Lena", "Eizenshtein")
            ]
        )
    );
  }

  void _addMockTask (Task task){
    _tasks[task.id] = task;
  }

  Future getTask(String id) async{
    return await _tasks[id];
  }
}