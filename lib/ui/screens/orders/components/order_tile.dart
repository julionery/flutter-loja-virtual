import 'package:flutter/material.dart';
import 'package:lojavirtual/models/order.dart';
import 'package:lojavirtual/ui/screens/orders/components/order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: primaryColor),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14),
                )
              ],
            ),
            Text(
              'Em transporte',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 14),
            )
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          )
        ],
      ),
    );
  }
}
