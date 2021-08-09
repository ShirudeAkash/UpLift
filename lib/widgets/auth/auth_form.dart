// import 'dart:html';

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // const AuthForm({Key? key}) : super(key: key);

  AuthForm(
    this.submitFn,
    this.isLoading,
  );
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          isLogin, context);
      print('form is valid');
    } else {
      print('form invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value == null || !(value.contains('@'))) {
                        return 'Please Enter correct email address';
                      } else
                        return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (value) {
                      if (value != null) _userEmail = value;
                    },
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Too short username';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        if (value != null) _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Password must br 8 character long';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      if (value != null) _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading)
                    CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  if (!widget.isLoading)
                    ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(isLogin ? 'Login' : 'Sign UP')),
                  if (!widget.isLoading)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(isLogin
                            ? 'Crete new Account'
                            : 'I Already have an account'))
                ],
              )),
        )),
      ),
    );
  }
}
