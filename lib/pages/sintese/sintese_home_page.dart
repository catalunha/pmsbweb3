import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class SinteseHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      backgroundColor: Colors.red,
      title: Text("Síntese dos questionários"),
      body: Center(
        child: Text(
          "Em construção.",
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
