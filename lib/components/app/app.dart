@HtmlImport('app.html')
library demo.wrike.component.mainapp;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'dart:html';
import 'dart:async';

import 'package:wrike_demo/components/input_component/input_component.dart';

import 'package:wrike_demo/model/service/MockService.dart';

import 'package:wrike_demo/model/vo/task.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  MockService _dataService = new MockService();

  @property
  final validators = {
    "fullName": fullNameValidator,
    "numberValidator": numberValidator
  };

  final SHUFFLE_TIME = const Duration(seconds: 1);

  bool _isTaskModified = false;

  bool _allAssigneesValid = true;

  Timer _shuffleTimer = null;

  @property
  bool isAssigneesExist = false;

  @property
  bool isTaskIdValid = false;

  @property
  bool isTaskValidForUpdate = false;

  @property
  Task task = null;

  @property
  String shuffleLabel = "Do shuffle";

  factory MainApp() => new Element.tag('main-app');
  MainApp.created() : super.created();

  /////////////// getters / setters start ///////////////

  void _setTask(value) {
    if (task == value) {
      //handle case when selected Object is taken from cache
      set('task', null);
      $['assignees'].render();
    }
    task = value;
    set('task', task);

    if (task.assignee != null && task.assignee.length > 0) {
      _setIsAssigneesExist(true);
    }
  }

  void _setAllAssigneesValid(value) {
    _allAssigneesValid = value;

    _setIsValidForUpdate();
  }

  void _setIsAssigneesExist(value) {
    isAssigneesExist = value;
    set('isAssigneesExist', isAssigneesExist);
  }

  void _setIsTaskModified(value) {
    _isTaskModified = value;

    _setIsValidForUpdate();
  }

  void _setIsValidForUpdate() {
    isTaskValidForUpdate = _isTaskModified && _allAssigneesValid;
    set('isTaskValidForUpdate', isTaskValidForUpdate);
  }

  void _setShuffleTimerLabel(value) {
    shuffleLabel = value;
    set('shuffleLabel', shuffleLabel);
  }
  /////////////// getters / setters end ///////////////

  ///////////// private methods start /////////////////

  _toggleShuffleTimer() {
    _shuffleTimer == null ? _startTimer() : _stopTimer();
  }

  _onTimerTick(Timer timer) {
    querySelectorAll(".assignees").forEach((component) {
      component.setValue(_dataService.getRandomName());
    });
    _setIsTaskModified(true);
  }

  _startTimer() {
    _shuffleTimer = new Timer.periodic(SHUFFLE_TIME, _onTimerTick);

    _setShuffleTimerLabel("Cancel shuffle");
  }

  _stopTimer() {
    if (_shuffleTimer == null) return;

    _shuffleTimer.cancel();
    _shuffleTimer = null;

    _setShuffleTimerLabel("Do shuffle");
  }

  _getData() async {
    _setIsTaskModified(false);
    _setAllAssigneesValid(true);
    _setIsAssigneesExist(false);

    _stopTimer();

    _dataService.getTask($['taskId'].value).then((task) {
      _setTask(task);
    });
  }

  void _validateAssingees() {
    var allValid = true;
    List components = querySelectorAll(".assignees");
    components.forEach((component) {
      if (!component.isValid) allValid = false;
    });

    _setAllAssigneesValid(allValid);
  }

  ///////////// private methods end /////////////////

  ///////////// event handlers start //////////////////
  @reflectable
  getData(e, target) {
    _getData();
  }

  @reflectable
  void updateTaskIdValid(e, target) {
    isTaskIdValid = e.currentTarget.isValid;
    set('isTaskIdValid', isTaskIdValid);
  }

  @reflectable
  void changeAssignee(e, [_]) {
    _setIsTaskModified(true);

    _validateAssingees();
  }

  /**
   * Data is saved in objects only on update not to override values
   * stored in cache
   */
  @reflectable
  updateData(e, target) {
    _setIsTaskModified(false);

    _stopTimer();

    var i = 0;
    List components = querySelectorAll(".assignees");
    components.forEach((component) {
      task.assignee[i].fullName = component.value.trim();
      i++;
    });

    _dataService.updateTask(task).catchError((_) {
      _getData();
      window.alert('Error happened');
    });
  }

  @reflectable
  void updateShuffle(e, target) {
    _toggleShuffleTimer();
  }
  ///////////// event handlers end //////////////////

  //////////////// validators start //////////////
  @reflectable
  static bool fullNameValidator(String value) {
    RegExp regexp = new RegExp("^[a-zA-z]*\\s[a-zA-z]*\$");
    return regexp.firstMatch(value.trim()) != null;
  }

  @reflectable
  static bool numberValidator(String value) {
    if (value == null || value.trim() == "") return false;

    RegExp regexp = new RegExp("^[0-9]*\$");
    return regexp.firstMatch(value.trim()) != null;
  }
  //////////////// validators end /////////////////

}
