import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_in');
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      // height:
      //     _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 105,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: ListTile(
                  title: Text(
                    DateFormat("EEE, MMM d, ''yy")
                        .format(widget.order.dateTime),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order No:${widget.order.id}'),
                      if (!_expanded)
                        Row(
                          children: [
                            Text("Delivery Status: "),
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      '\₹${myFormat.format(widget.order.amount)}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              AnimatedSize(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 300),
                child: _expanded
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        child: Column(
                          children: [
                            ...widget.order.products
                                .map(
                                  (prod) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          prod.title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${prod.quantity} x \₹${myFormat.format(prod.price)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                            DeliveryStatus(),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: 0,
      controlsBuilder: (context, {onStepContinue, onStepCancel}) {
        return SizedBox();
      },
      onStepTapped: (int index) {},
      steps: <Step>[
        Step(
          title: const Text(
            'Pending',
            style:
                TextStyle(color: Color.fromRGBO(255, 103, 0, 1), fontSize: 20),
          ),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Processing your order')),
        ),
        const Step(
          title: Text(
            'Shipping',
            style: TextStyle(fontSize: 15),
          ),
          content: Text('Content for Step 2'),
        ),
        const Step(
          title: Text(
            'Out for delivery',
            style: TextStyle(fontSize: 15),
          ),
          content: Text('Content for Step 2'),
        ),
        const Step(
          title: Text(
            'Delivered',
            style: TextStyle(fontSize: 15),
          ),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}
