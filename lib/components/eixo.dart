import 'package:flutter_web/material.dart';
import 'package:pmsbweb/models/usuario_model.dart';
import 'package:pmsbweb/state/auth_bloc.dart';

class EixoAtualUsuario extends StatelessWidget {
  final AuthBloc authBloc;

  EixoAtualUsuario(this.authBloc);

  @override
  Widget build(BuildContext context) {
    // final authBloc = Provider.of<AuthBloc>(context);
    return StreamBuilder<UsuarioModel>(
      stream: authBloc.perfil,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("ERROR"),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text("SEM DADOS"),
          );
        }
        return Text(
          "Eixo: ${snapshot.data.eixoIDAtual.nome}",
          style: TextStyle(fontSize: 16, color: Colors.blue),
        );
      },
    );
  }
}
