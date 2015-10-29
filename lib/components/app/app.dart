@HtmlImport('app.html')
library demo.wrike.component.mainapp;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'dart:html';
import 'dart:js';

import 'package:wrike_demo/components/input_component/input_component.dart';

@PolymerRegister('main-app')
class MainApp extends PolymerElement{

  factory MainApp() => new Element.tag('main-app');
  MainApp.created() : super.created();

}

