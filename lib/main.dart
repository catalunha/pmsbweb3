import 'package:flutter_web/material.dart';
import 'package:pmsbweb/pages/configuracoes/configuracoes_home_page.dart';
import 'package:pmsbweb/pages/controle/controle_home_page.dart';
import 'package:pmsbweb/pages/noticias/noticias_page.dart';
import 'package:pmsbweb/pages/pages.dart';
import 'package:pmsbweb/pages/perfil/perfil_home_page.dart';

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
              "/home": (context) => NoticiasPage(),
              //comunicacao
              "/comunicacao": (context) => CommunicationPage(),
              "/comunicacao/criar_editar": (context) => CommunicationCreateEdit(),
              //produto
              "/produto": (context) => ProductPage(),
              "/produto/adicionar_editar": (context) => AddEditProduct(),
              "/produto/lista": (context) => ProductList(),
              "/produto/visual": (context) => ProductVisual(),
              "/produto/editar_visual": (context) => EditVisual(),

              "/questionario/home":(context) => QuestionarioHomePage(),
              "/pergunta/home":(context) => PerguntaHomePage(),
              "/aplicacao/home":(context) => AplicacaoHomePage(),
              "/resposta/home":(context) => RespostaHomePage(),
              "/sintese/home":(context) => SinteseHomePage(),

               //administração
              "/administracao/home":(context) => AdministracaoHomePage(),
              "/administracao/perfil":(context) => AdministracaoPerfilPage(),

              //controle
              "/controle/home":(context) => ControleHomePage(),

              "/perfil":(context) => PerfilHomePage(),
              "/perfil/configuracao":(context) => ConfiguracoesHomePage()

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