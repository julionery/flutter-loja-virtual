import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/models/home/page_manager.dart';
import 'package:lojavirtual/models/user/user_manager.dart';
import 'package:lojavirtual/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/ui/screens/admin_orders/admin_orders_screen.dart';
import 'package:lojavirtual/ui/screens/admin_users/admin_users_screen.dart';
import 'package:lojavirtual/ui/screens/home/home_screen.dart';
import 'package:lojavirtual/ui/screens/orders/orders_screen.dart';
import 'package:lojavirtual/ui/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ProductsScreen(),
              OrdersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home 4'),
                ),
              ),
              if (userManager.adminEnabled) ...[
                AdminUsersScreen(),
                AdminOrdersScreen()
              ]
            ],
          );
        },
      ),
    );
  }
}
