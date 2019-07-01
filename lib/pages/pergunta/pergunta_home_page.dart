import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class PerguntaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Text(
            "Aplicativo: Pergunta",
            style: Theme.of(context).textTheme.display1,
          ),
          Padding(padding: EdgeInsets.all(10)),
          Image.asset(
            "images/construcao.png",
            width: 600,
          ),
        ],
      )),
    );
  }
}
