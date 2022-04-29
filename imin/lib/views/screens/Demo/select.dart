import 'package:flutter/material.dart';

class Selector extends StatefulWidget {
  const Selector({Key? key}) : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  int selected = -1; //attention

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Short Product"),
      ),
      body: ListView.builder(
        key: Key('builder ${selected.toString()}'), //attention
        itemCount: 10,
        itemBuilder: (context, i) {
          return ExpansionTile(
              key: Key(i.toString()), //attention
              initiallyExpanded: i == selected, //attention
              title: Text(i.toString()),
              children: _Product_ExpandAble_List_Builder(i),
              onExpansionChanged: ((newState) {
                if (newState)
                  setState(() {
                    selected = i;
                  });
                else
                  setState(() {
                    selected = -1;
                  });
              }));
        },
      ),
    );
  }

  _Product_ExpandAble_List_Builder(int cat_id) {
    List<Widget> columnContent = [];
    [1, 2, 4, 5].forEach((product) => {
          columnContent.add(
            ListTile(
              title: ExpansionTile(
                title: Text(product.toString()),
              ),
              trailing: Text("$product (Kg)"),
            ),
          ),
        });
    return columnContent;
  }
}
