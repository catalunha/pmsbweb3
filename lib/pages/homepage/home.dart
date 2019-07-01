import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: Text('Home'),
    );
  }
}
