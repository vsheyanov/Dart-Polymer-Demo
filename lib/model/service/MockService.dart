library demo.wrike.model.service.mockservice;

import 'dart:async';

import 'package:wrike_demo/model/vo/user.dart';
import 'package:wrike_demo/model/vo/task.dart';

import 'dart:html';
import 'dart:convert';


class MockService {

  static final MockService _instance = new MockService._internal();

  MockService._internal();

  Map<String, dynamic> _cache = new Map();

  static final _names = [
    "Victor Ivanov", "Ivan Petrov", "Alina Mihailova", "Katya Oficerova",
    "Michail Gorbachev", "Vladimir Lenin", "Angela Merkel"
  ];

  factory MockService(){
    return _instance;
  }

  String getRandomName(){
    _names.shuffle();
    return _names[0];
  }

  Future getTask(String id) async{
    if (_cache[id] != null)
      return _cache[id];

    return HttpRequest.postFormData('http://putsreq.com/3YzUAy7UnEjZenzpcusM', {'taskId': id})
        .then((result){
            print("Data received from the server: ${result.response}");

            var task = new Task.fromJson(JSON.decode(result.response));

            _cache[task.id] = task;

            print ('got task');

            return task;
        });
  }

  Future updateTask(Task task) {

    var jsonData = JSON.encode(task);

    print("Data sent to server: $jsonData");

    return HttpRequest.postFormData('http://putsreq.com/pzYWFpFfZaOxac7CRV6t', {'task' : jsonData})
        .then((result){
          if (result.response == "error"){
            _cache.remove(task.id);
            return new Future.error("Error happened");
          } else {
            _cache[task.id] = task;
          }
        });
  }
}