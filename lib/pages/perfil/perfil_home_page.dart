
import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class PerfilHomePage extends StatefulWidget {
  @override
  _PerfilHomePageState createState() => _PerfilHomePageState();
}

class _PerfilHomePageState extends State<PerfilHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Text(
            "Aplicativo: Perfil",
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