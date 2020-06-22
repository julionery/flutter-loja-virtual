import 'package:flutter/material.dart';
import 'package:lojavirtual/models/managers/user_manager.dart';
import 'file:///D:/GitHub/flutter-loja-virtual/lib/models/managers/page_manager.dart';
import 'package:lojavirtual/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/ui/screens/admin_users/admin_users_screen.dart';
import 'package:lojavirtual/ui/screens/home/home_screen.dart';
import 'package:lojavirtual/ui/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

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
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home 3'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home 4'),
                ),
              ),
              if (userManager.adminEnabled) ...[
                AdminUsersScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
