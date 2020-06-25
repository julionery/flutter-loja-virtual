import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/admin/admin_orders_manager.dart';
import 'package:lojavirtual/models/order/order.dart';
import 'package:lojavirtual/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/ui/common/custom_icon_button.dart';
import 'package:lojavirtual/ui/common/empty_card.dart';
import 'package:lojavirtual/ui/common/order/order_tile.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersScreen extends StatefulWidget {
  @override
  _AdminOrdersScreenState createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Todos os Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrdersManager, __) {
          final filteredOrders = adminOrdersManager.filteredOrders;

          return SlidingUpPanel(
            controller: panelController,
            body: Column(
              children: [
                if (adminOrdersManager.userFilter != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Pedidos de ${adminOrdersManager.userFilter.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CustomIconButton(
                          iconData: Icons.close,
                          color: Colors.white,
                          onTap: () {
                            adminOrdersManager.setUserFilter(null);
                          },
                        )
                      ],
                    ),
                  ),
                if (filteredOrders.isEmpty)
                  const Expanded(
                    child: EmptyCard(
                      title: 'Nenhuma venda realizada!',
                      iconData: Icons.border_clear,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (_, index) {
                          return OrderTile(
                            filteredOrders[index],
                            showControls: true,
                          );
                        }),
                  ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
            minHeight: 40,
            maxHeight: 250,
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelClosed) {
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },
                  child: Container(
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: Status.values.map((s) {
                      return CheckboxListTile(
                        title: Text(Order.getStatusText(s)),
                        dense: true,
                        activeColor: Theme.of(context).primaryColor,
                        value: adminOrdersManager.statusFilter.contains(s),
                        onChanged: (v) {
                          adminOrdersManager.setStatusFilter(
                              status: s, enabled: v);
                        },
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
