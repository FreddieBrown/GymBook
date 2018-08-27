import 'package:flutter/material.dart';
class FormMaker{

  Widget form(List<String> name, List<TextEditingController> controller, List<int> lines, List<int> chars, List<Function> func){
    int l = name.length;
    List<Widget> list = [];
    for(int i = 0; i < l; i++){
      list.add(Text(
        name[i],
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0)
      ));
      list.add(_field(name[i], lines[i], controller[i], func[i], chars[i]));
    }
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: ListView(
          children: list
        )
    );
  }

  Widget _field(String label, int lines,  TextEditingController controller, Function func, [int chars = null]){
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TextFormField(
        validator: func,
        controller: controller,
        maxLines: lines,
        maxLength: chars,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: label
        ),
      ),
    );
  }
}