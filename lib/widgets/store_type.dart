import 'package:flutter/material.dart';

class StoreType extends StatefulWidget {
  @override
  State<StoreType> createState() => _StoreTypeState();
}

class _StoreTypeState extends State<StoreType> {
  List<String> stores = ["MI HOME", "MI STORE"];
  String curStore = "MI HOME";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: stores[0],
            groupValue: curStore,
            onChanged: (val) {
              setState(() {
                curStore = val;
              });
            }),
        Text("MI HOME"),
        Spacer(),
        Radio(
            value: stores[1],
            groupValue: curStore,
            onChanged: (val) {
              setState(() {
                curStore = val;
              });
            }),
        Text("MI STORE"),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
