import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';
import 'package:pmsbweb/components/square_image.dart';
//import 'package:pmsbweb/models/perfis_usuarios_model.dart';
//import 'administracao_home_page_bloc.dart';

class AdministracaoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: Text("Administração"),
      backgroundColor: Colors.red,
      body: Container(
        child: ListView(
          children: <Widget>[
            PerfilUsuarioItem(),
            PerfilUsuarioItem(),
            PerfilUsuarioItem(),
            PerfilUsuarioItem()
          ],
        ),
      ),
    );
  }
}

class PerfilUsuarioItem extends StatelessWidget {
  //final PerfilUsuarioModel usuario;

  PerfilUsuarioItem();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/administracao/perfil");
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: SquareImage(
                    image: NetworkImage(
                        "https://pingendo.github.io/pingendo-bootstrap/assets/user_placeholder.png"),
                  )),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Nome: #usuario.nomeProjeto "),
                      Text("Celular: #usuario.celular"),
                      Text("Email: #usuario.email}"),
                      Text("Eixo: #usuario.eixo"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
