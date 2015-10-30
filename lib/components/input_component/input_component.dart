@HtmlImport('input_component.html')
library demo.wrike.component.inputcomponent;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:html';

@PolymerRegister('input-component')
class InputComponent extends PolymerElement{

  factory InputComponent() => new Element.tag('input-component');
  InputComponent.created() : super.created();

  @property
  String validationTitle = "";

  @property
  bool isValid = true;

  @property
  var validator;

  @Property(observer: 'valueChanged')
  String value;

  @property
  String validStyle = "visibility: hidden";

  @reflectable
  void valueChanged(String newValue, String oldValue){
    _validate(newValue);
  }

  void _validate(String newValue){
    if (validator != null){
      isValid = validator(newValue);
      set('isValid', isValid);

      validStyle = "visibility: ${!isValid ? 'visible' : 'hidden'}";
      set('validStyle', validStyle);
    }
  }
}

