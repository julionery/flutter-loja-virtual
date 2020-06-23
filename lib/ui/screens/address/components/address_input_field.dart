import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/models/address.dart';

class AddressInputField extends StatelessWidget {
  final Address address;

  const AddressInputField(this.address);

  @override
  Widget build(BuildContext context) {
    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;

    final primaryColor = Theme.of(context).primaryColor;
    if (address.zipCode != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            initialValue: address.street,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Rua/Avenida',
                hintText: 'Av. Brasil'),
            validator: emptyValidator,
            onSaved: (t) => address.street = t,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: address.number,
                  decoration: const InputDecoration(
                      isDense: true, labelText: 'Número', hintText: '123'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  validator: emptyValidator,
                  onSaved: (t) => address.number = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: address.complement,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Complemento',
                      hintText: 'Opcional'),
                  onSaved: (t) => address.complement = t,
                ),
              )
            ],
          ),
          TextFormField(
            initialValue: address.district,
            decoration: const InputDecoration(
                isDense: true, labelText: 'Bairro', hintText: 'Centro'),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  initialValue: address.city,
                  enabled: false,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Cidade',
                      hintText: 'Rio Verde'),
                  validator: emptyValidator,
                  onSaved: (t) => address.city = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  autocorrect: false,
                  enabled: false,
                  textCapitalization: TextCapitalization.characters,
                  initialValue: address.state,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'UF',
                      hintText: 'GO',
                      counterText: ''),
                  maxLength: 2,
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (e.length != 2) {
                      return 'Inválido';
                    }
                    return null;
                  },
                  onSaved: (t) => address.state = t,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          RaisedButton(
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            textColor: Colors.white,
            onPressed: () {},
            child: const Text('Calcular Frete'),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
