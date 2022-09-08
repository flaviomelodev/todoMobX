// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:mobx_todo/stores/login_store.dart';

import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextField(
                      hint: 'E-mail',
                      prefix: const Icon(Icons.account_circle),
                      textInputType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: const Icon(Icons.lock),
                        obscure: !loginStore.showPassord,
                        onChanged: loginStore.setPassword,
                        enabled: true,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: loginStore.showPassord
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onTap: loginStore.togglePassword,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 44,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          // ignore: sort_child_properties_last
                          child: loginStore.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text('Login'),
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: loginStore.loginPressed as Function()?,
                        ),
                      );
                    }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
