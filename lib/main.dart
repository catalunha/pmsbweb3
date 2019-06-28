import 'package:flutter_web/material.dart';
import 'package:pmsbweb/pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
              "/": (context) => LoginPage(),
              "/home": (context) => HomePage(),
              "/comunicacao": (context) => CommunicationPage(),
              "/comunicacao/criar_editar": (context) => CommunicationCreateEdit(),
            },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}