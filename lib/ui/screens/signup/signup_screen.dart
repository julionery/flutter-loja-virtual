import 'package:lojavirtual/models/managers/user_manager.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode emailFocus = FocusNode();

  FocusNode passFocus = FocusNode();

  FocusNode confirmPassFocus = FocusNode();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      autocorrect: false,
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Campo obrigatório.';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu Nome Completo.';
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                      onEditingComplete: () {
                        emailFocus.nextFocus();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      focusNode: emailFocus,
                      validator: (email) {
                        if (email.isEmpty) return 'Campo obrigatório.';
                        if (!emailValid(email)) return 'E-mail inválido.';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                      onEditingComplete: () {
                        passFocus.nextFocus();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      focusNode: passFocus,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty) return 'Informe a senha.';
                        if (pass.length < 6) return 'Senha muito curta.';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                      onEditingComplete: () {
                        confirmPassFocus.nextFocus();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Repita a Senha'),
                      autocorrect: false,
                      obscureText: true,
                      focusNode: confirmPassFocus,
                      validator: (pass) {
                        if (pass.isEmpty) return 'Informe a senha.';
                        if (pass.length < 6) return 'Senha muito curta.';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();

                                  if (user.password != user.confirmPassword) {
                                    scaffoldKey.currentState
                                        .showSnackBar(const SnackBar(
                                      content: Text('Senhas não coincidem!'),
                                      backgroundColor: Colors.red,
                                    ));
                                    return;
                                  }

                                  userManager.signUp(
                                      user: user,
                                      onFail: (e) {
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ));
                                      },
                                      onSuccess: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      });
                                }
                              },
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Criar Conta',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
