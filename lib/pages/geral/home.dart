import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/login_required.dart';
import 'package:pmsbweb/pages/comunicacao/noticia_leitura_page.dart';
import 'package:pmsbweb/state/auth_bloc.dart';


class HomePage extends StatelessWidget {
  final AuthBloc authBloc;
    HomePage(this.authBloc);

  @override
  Widget build(BuildContext context) {

    return DefaultLoginRequired(
      child: NoticiaLeituraPage(),
      authBloc:this.authBloc,
      // child: NoticiasNaoVisualizadasPage(),
    );
  }
}
