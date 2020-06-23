import 'package:flutter/material.dart';
import 'package:lojavirtual/ui/screens/address/components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [AddressCard()],
      ),
    );
  }
}
