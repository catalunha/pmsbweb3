import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class ConfiguracoesHomePage extends StatefulWidget {
  @override
  _ConfiguracoesHomePageState createState() => _ConfiguracoesHomePageState();
}

class _ConfiguracoesHomePageState extends State<ConfiguracoesHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Text(
            "Aplicativo: Configurações",
            style: Theme.of(context).textTheme.display1,
          ),
          Padding(padding: EdgeInsets.all(10)),
          Image.asset(
            "images/ligando.png",
            width: 400,
          ),
          Padding(padding: EdgeInsets.all(10)),
           Text(
            "Conectando dados a interface",
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      )),
    );
  }
}