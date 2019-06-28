import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';
import 'package:pmsbweb/pages/pages.dart';

class CommunicationPage extends StatefulWidget {
  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: Text("Comunicação"),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _cardBuild(),
          _cardBuild(),
        ],
      ),
    );
  }

  Widget _appBarBuild(context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            modalEscolhaDeTipoFiltro(context);
          },
        ),
        //MoreAppAction(),
      ],
      //leading: Text("leading"),
      centerTitle: true,
      title: Text("Eixo de comunicaçsão"),
    );
  }

  Widget _cardBuild() {
    return Card(
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Text('Noticia teste'),
              subtitle: Text(
                  '01/02/0202 - 01/02/0202: \nMusic by Julie Gable. https://api.flutter.dev/flutter/material/ListTile-class.html Lyrics by Sidney Stein. Music by Julie Gable. Lyrics by Sidney Stein.Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.archive),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      Navigator.pushNamed(context, '/comunicacao/criar_editar');
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }  
}