import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  _body(){
    return Container(color: Colors.green,);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: _body(),
    );
  }
}