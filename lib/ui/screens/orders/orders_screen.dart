import 'package:flutter/material.dart';
import 'package:lojavirtual/models/managers/orders_manager.dart';
import 'package:lojavirtual/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/ui/common/empty_card.dart';
import 'package:lojavirtual/ui/common/login_card.dart';
import 'package:lojavirtual/ui/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return LoginCard();
          }

          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }

          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(ordersManager.orders.reversed.toList()[index]);
            },
          );
        },
      ),
    );
  }
}
