import 'dart:async';

import 'package:flutter_web/material.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:pmsbweb/api/auth_api_mobile.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/state/auth_bloc.dart';
// import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc =
      Bootstrap.instance.authBloc;
  LoginPage();

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  //PermissionStatus _status;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_checkPermission();
  }

  // TODO:

  // void _checkPermission() async {
  //   var a = PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  //   await a.then(_updateStatus);
  // }

  // FutureOr _updateStatus(PermissionStatus value) {
  //   if (value == PermissionStatus.denied) {
  //     _askPermission();
  //   }
  // }

  // _askPermission() async {
  //   var a = PermissionHandler().requestPermissions([
  //     PermissionGroup.storage,
  //   ]);
  //   await a.then(_onStatusRequested);
  // }

  // FutureOr _onStatusRequested(Map<PermissionGroup, PermissionStatus> value) {
  //   _updateStatus(value[PermissionGroup.storage]);
  // }

  @override
  Widget build(BuildContext context) {
    // var authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('images/logos/Splash_1024x1024.png'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: TextFormField(
                          onSaved: (email) {
                            widget.authBloc.dispatch(UpdateEmailAuthBlocEvent(email));
                          },
                          decoration: InputDecoration(
                            hintText: "Informe seu email",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: TextFormField(
                          onSaved: (password) {
                            widget.authBloc.dispatch(
                                UpdatePasswordAuthBlocEvent(password));
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Informe sua senha",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: RaisedButton(
                          child: Text("Acessar com email e senha"),
                          onPressed: () {
                            _formKey.currentState.save();
                            widget.authBloc.dispatch(LoginAuthBlocEvent());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
