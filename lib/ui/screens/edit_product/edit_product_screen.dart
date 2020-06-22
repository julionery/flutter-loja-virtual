import 'package:flutter/material.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/ui/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  EditProductScreen(this.product);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anúncio'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                        hintText: 'Título', border: InputBorder.none),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                    validator: (name) {
                      if (name.isEmpty) return 'Informe o título.';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                        fontSize: 22,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Descrição:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                        hintText: 'Descrição', border: InputBorder.none),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.isEmpty) return 'Informe a descrição.';
                      return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        print('valido');
                      } else {
                        print('invalido');
                      }
                    },
                    child: const Text('Salvar'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
