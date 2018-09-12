import 'package:flutter/material.dart';

class FormMaker {
  Widget form(List<String> name, List<TextEditingController> controller,
      List<int> lines, List<int> chars, List<Function> func, List<bool> autof) {
    int l = name.length;
    List<Widget> list = [];
    for (int i = 0; i < l; i++) {
      list.add(Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Text(name[i],
              style: const TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0))));
      list.add(_field(
          name[i], lines[i], controller[i], func[i], chars[i], autof[i]));
    }
    return Container(
        padding: EdgeInsets.only(top: 10.0), child: ListView(children: list));
  }

  Widget _field(
      String label, int lines, TextEditingController controller, Function func,
      [int chars = null, bool autof = false]) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: func,
        autofocus: autof,
        controller: controller,
        maxLines: lines,
        maxLength: chars,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(),
            hintText: label),
      ),
    );
  }
}
