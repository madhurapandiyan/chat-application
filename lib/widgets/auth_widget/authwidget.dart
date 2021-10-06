import 'dart:io';

import 'package:chat_app/size.dart';
import 'package:chat_app/widgets/auth_widget/profilephoto.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isloading);

  final void Function(String email, String password, String userName,
      bool isLogin, BuildContext ctx, File? image) submitFn;
  final bool isloading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var showpassword = false;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? filepicked;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    var findlogin=_isLogin==true? filepicked==null:filepicked; 

    if(_isLogin){
      _formKey.currentState!.save();
      widget.submitFn(
          _userEmail, _userPassword, "", _isLogin, context,null);
    }


    if (filepicked == null && _isLogin==false) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("please upload image")));
    }
    else if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
          _userEmail, _userPassword, _userName, _isLogin, context, filepicked);
    }
  }

  void getfile(File? picked) {
    filepicked = picked == null ? null : picked;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // print(_isLogin);
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
                  if (!_isLogin) Profilephoto(getfile),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                showpassword = !showpassword;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye))),
                    obscureText: showpassword == false ? true : false,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: () => _trySubmit(),
                    ),
                  if (!widget.isloading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
