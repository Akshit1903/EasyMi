import 'package:flutter/material.dart';

class CustomerForm extends StatefulWidget {
  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  String dropdownvalue = 'Credit/Debit Card';
  var items = [
    'Credit/Debit Card',
    'UPI',
    'Pay on Delivery',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Customer Name',
              floatingLabelStyle: TextStyle(
                color: Color.fromRGBO(255, 103, 0, 1),
              ),
              focusColor: Color.fromRGBO(255, 103, 0, 1),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(255, 103, 0, 1),
                  style: BorderStyle.solid,
                ),
              ),
            ),
            keyboardType: TextInputType.name,
          ),
        ),
        DropdownButton(
          focusColor: Color.fromRGBO(255, 103, 0, 1),
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(() {
              dropdownvalue = newValue;
            });
          },
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Colour',
                      floatingLabelStyle: TextStyle(
                        color: Color.fromRGBO(255, 103, 0, 1),
                      ),
                      focusColor: Color.fromRGBO(255, 103, 0, 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 103, 0, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Size',
                      floatingLabelStyle: TextStyle(
                        color: Color.fromRGBO(255, 103, 0, 1),
                      ),
                      focusColor: Color.fromRGBO(255, 103, 0, 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 103, 0, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
