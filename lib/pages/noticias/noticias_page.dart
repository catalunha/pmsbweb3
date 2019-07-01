import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  Widget _cardBuild() {
    return Container(
      padding: EdgeInsets.all(6),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              //leading: Text("asdf"),
              title: Text("Noticia"),
              subtitle: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            ),
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.centerRight,
              child: Icon(Icons.thumb_up),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          _cardBuild(),
          _cardBuild(),
          _cardBuild(),
          _cardBuild(),
          _cardBuild(),
        ],
      ),
    ));
  }
}
