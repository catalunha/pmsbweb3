import 'package:flutter_web/material.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/models/usuario_model.dart';
import 'package:pmsbweb/state/auth_bloc.dart';

class Rota {
  final String nome;
  final Icons;

  Rota(this.nome, this.Icons);
}

class DefaultDrawer extends StatelessWidget {
  final AuthBloc authBloc;
  Map<String, Rota> rotas;
  DefaultDrawer() : authBloc = Bootstrap.instance.authBloc {
    // Map<String, Rota>
    rotas = Map<String, Rota>();
    //rotas["/desenvolvimento"] = Rota("Desenvolvimento", Icons.build);
    //rotas["/"] = Rota("Home", Icons.home);
    // rotas["/upload"] = Rota("Upload de arquivos", Icons.file_upload);
    rotas["/questionario/home"] = Rota("Questionários", Icons.assignment);
    //rotas["/aplicacao/home"] = Rota("Aplicar Questionário", Icons.directions_walk);
    // rotas["/resposta/home"] = Rota("Resposta", Icons.playlist_add_check);
    // rotas["/sintese/home"] = Rota("Síntese", Icons.equalizer);
    // rotas["/produto/home"] = Rota("Produto", Icons.chrome_reader_mode);
    //rotas["/comunicacao/home"] = Rota("Comunicação", Icons.contact_mail);
    // rotas["/administracao/home"] = Rota("Administração", Icons.business_center);
    // rotas["/controle/home"] = Rota("Controle", Icons.control_point);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            StreamBuilder<UsuarioModel>(
              stream: authBloc.perfil,
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(
                    child: Text("Erro"),
                  );
                }
                if (!snap.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                Widget imagem = Icon(Icons.people, size: 75);
                if (snap.data?.foto?.localPath != null) {
                  imagem = Container(
                      color: Colors.yellow,
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage(snap.data?.foto?.localPath),
                            minRadius: 50,
                            maxRadius: 50,
                          )));
                } else if (snap.data?.foto?.url != null) {
                  imagem = CircleAvatar(
                    backgroundImage: NetworkImage(snap.data?.foto?.url),
                    minRadius: 50,
                    maxRadius: 50,
                  );
                }
                return DrawerHeader(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).textTheme.title.color),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(flex: 4, child: imagem),
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text("${snap.data.nome}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text("${snap.data.celular}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child:
                                          Text("${snap.data.eixoIDAtual.nome}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                          "${snap.data.setorCensitarioID.nome}"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("${snap.data.email}"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            StreamBuilder<UsuarioModel>(
              stream: authBloc.perfil,
              builder:
                  (BuildContext context, AsyncSnapshot<UsuarioModel> snap) {
                if (snap.hasError) {
                  return Center(
                    child: Text("Erro"),
                  );
                }
                if (!snap.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Widget> list = List<Widget>();
                if (snap.data == null ||
                    snap.data.routes == null ||
                    snap.data.routes.isEmpty) {
                  list.add(Container(
                    height: 50,
                    color: Colors.green,
                  ));
                } else {
                  rotas.forEach((k, v) {
                    if (snap.data.routes.contains(k)) {
                      list.add(ListTile(
                        title: Text(v.nome),
                        trailing: Icon(v.Icons),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, k);
                        },
                      ));
                    }
                  });
                }
                if (list.isEmpty || list == null) {
                  list.add(Container(color: Colors.red));
                }
                return Expanded(child: ListView(children: list));

                // return ListTile(
                //         title: Text("v.nome"),
                //         trailing: Icon(Icons.ac_unit),
                //         onTap: () {
                //           //Navigator.pushReplacementNamed(context, k);
                //         },
                //       );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DefaultEndDrawer extends StatelessWidget {
  final AuthBloc authBloc;
  DefaultEndDrawer() : authBloc = Bootstrap.instance.authBloc;

  @override
  Widget build(BuildContext context) {
    // var authBloc = Provider.of<AuthBloc>(context);
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/perfil/configuracao");
              },
              leading: Icon(Icons.settings),
            ),
            // Divider(
            //   color: Colors.black45,
            // ),
            // ListTile(
            //   title: Text('Perfil'),
            //   onTap: () {
            //     //noticias perfil
            //     Navigator.pop(context);
            //     Navigator.pushNamed(context, "/perfil");
            //   },
            //   leading: Icon(Icons.person),
            // ),
            // Divider(
            //   color: Colors.black45,
            // ),
            // ListTile(
            //   title: Text('Noticias lidas'),
            //   onTap: () {
            //     //noticias arquivadas
            //     Navigator.pop(context);
            //     Navigator.pushNamed(context, "/noticias/noticias_visualizadas");
            //   },
            //   leading: Icon(Icons.event_available),
            // ),
            Divider(
              color: Colors.black45,
            ),
            ListTile(
              title: Text('Trocar de usuário'),
              onTap: () {
                authBloc.dispatch(LogoutAuthBlocEvent());
              },
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreAppAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(Icons.more_vert),
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final Widget floatingActionButton;
  final Widget title;
  final Widget actions;
  final Widget bottom;
  final Color backgroundColor;
  const DefaultScaffold({
    Key key,
    this.body,
    this.floatingActionButton,
    this.title,
    this.actions,
    this.backgroundColor,
    this.bottom,
  }) : super(key: key);

  Widget _appBarBuild(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      actions: <Widget>[
        MoreAppAction(),
      ],
      //leading: Text("leading"),
      centerTitle: true,
      title: title,
      bottom: bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DefaultDrawer(),
      endDrawer: DefaultEndDrawer(),
      appBar: _appBarBuild(context),
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
