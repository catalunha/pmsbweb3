
import 'package:flutter_web/material.dart';

class LoginData {
  String password;
  String email;
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  LoginData _data = LoginData();

  @override
  Widget build(BuildContext context) {
    //userRepository = Provider.of<UserRepository>(context);
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
                child: Image.asset('images/logos/Splash_1024x1024.png',height: 400),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Form(
                  //key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: TextFormField(
                          onSaved: (email) {
                            _data.email = email;
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
                            _data.password = password;
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
                            Navigator.pushNamed(context, '/home');
                            //_formKey.currentState.save();
                            //userRepository.signIn(_data.email, _data.password);
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
