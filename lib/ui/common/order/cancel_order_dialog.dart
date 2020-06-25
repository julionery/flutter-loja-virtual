import 'package:flutter/material.dart';
import 'package:lojavirtual/models/order/order.dart';

class CancelOrderDialog extends StatelessWidget {
  final Order order;

  const CancelOrderDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar ${order.formattedId}?'),
      content: const Text('Esta ação não poderá ser desfeita!'),
      actions: [
        FlatButton(
          onPressed: () {
            order.cancel();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Cancelar Pedido'),
        )
      ],
    );
  }
}
