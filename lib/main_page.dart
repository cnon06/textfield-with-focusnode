import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController _te_controller;
  late FocusNode _focusNode;
  double? _fontSize = 10;

  @override
  void dispose() {
    // controller ve listenerlar sayfa replace edilse bile hafızadan silinmeyebilir o sebeple memory hataları ile karşılaşmamak için burada dispose etmek faydalı olacaktır.
    _te_controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _te_controller = TextEditingController(text: "C-NON Software");
    _focusNode = FocusNode();
    _focusNode.addListener(() {
       debugPrint("hasfocus: ${_focusNode.hasFocus}");

      _focusNode.hasFocus ? _fontSize = 20 : _fontSize = 15;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
          child: Center(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(fontSize: _fontSize),
              controller: _te_controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                  fillColor: Colors.black12,
                  filled: true,
                  label: Text("Label Text"),
                  hintText: "İpucu giriniz",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                  icon: Icon(Icons.add),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
              cursorColor: Colors.pink,
              textInputAction: TextInputAction.search,
              onChanged: (String value) {
                //TextEditingValue selection TextSelection.collapsed(offset: ) offset -1 ise imleci sürekli başa alır value.length ise sona alır.
                _te_controller.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length));
                setState(() {});
                debugPrint(value);
              },
              onSubmitted: (value) {
                debugPrint("onSubmitted: $value");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_te_controller.text),
          ),
          TextField(),
        ],
      ))),
    );
  }
}
