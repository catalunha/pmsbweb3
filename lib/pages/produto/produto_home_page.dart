import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';
import 'package:pmsbweb/models/produto_model.dart';

import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/pages/produto/produto_home_page_bloc.dart';
import 'package:pmsbweb/state/auth_bloc.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class ProdutoHomePage extends StatefulWidget {
  AuthBloc authBloc;
  ProdutoHomePage(this.authBloc);

  _ProdutoHomePageState createState() => _ProdutoHomePageState(this.authBloc);
}

class _ProdutoHomePageState extends State<ProdutoHomePage> {
  final ProdutoHomePageBloc bloc;
  _ProdutoHomePageState(AuthBloc authBloc)
      : bloc = ProdutoHomePageBloc(Bootstrap.instance.firestore, authBloc);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  _listaProdutos(BuildContext context) {
    return StreamBuilder<List<ProdutoModel>>(
        stream: bloc.produtoModelListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text("Erro. Informe ao administrador do aplicativo"),
            );
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text("Nenhum produto criado."),
            );
          }

          return ListView(
            children: snapshot.data
                .map((produto) => _cardBuildProduto(context, produto))
                .toList(),
          );
        });
  }

  Widget _cardBuildProduto(BuildContext context, ProdutoModel produto) {
    return Card(
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: produto.titulo != null
                  ? Text(produto.titulo)
                  : Text('Sem titulo'),
              subtitle: produto.usuarioID?.nome != null
                  ? Text(
                      'Último editor: ${produto.usuarioID?.nome}\n${produto.modificado}')
                  : Text('Sem editor'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                tooltip: 'Editar titulo ou apagar este produto',
                onPressed: () {
                  //Ir a pagina de Adicionar ou editar Produtos
                  Navigator.pushNamed(context, '/produto/crud',
                      arguments: produto.id);
                },
              ),
            ),
            // ButtonTheme.bar(
            //   child:
            Wrap(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.format_textdirection_l_to_r),
                  tooltip: 'Editar texto',
                  onPressed: produto?.googleDrive?.arquivoID != null
                      ? () {
                          html.window.open(produto?.googleDrive?.url(), "name");
                          //Ir para a edição do produto,
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  tooltip: 'PDF finalizado do produto.',
                  onPressed: produto.pdf?.url != null
                      ? () {
                          //launch(produto.pdf?.url);
                        }
                      : null,
                ),
              ],
            )
          ],
        ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<ProdutoHomePageState>(
          stream: bloc.stateStream,
          builder: (BuildContext context,
              AsyncSnapshot<ProdutoHomePageState> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando.."),
                  ],
                ),
              );
            }
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: snapshot.data?.usuarioModel?.eixoIDAtual?.nome != null
                      ? Text(
                          "Eixo: ${snapshot.data.usuarioModel.eixoIDAtual.nome}",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        )
                      : Text('...'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: snapshot.data?.usuarioModel?.setorCensitarioID?.nome !=
                          null
                      ? Text(
                          "Setor: ${snapshot.data.usuarioModel.setorCensitarioID.nome}",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        )
                      : Text('...'),
                ),
              ],
            );
          },
        ),
        Expanded(child: _listaProdutos(context))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: Text("Produto"),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/produto/crud', arguments: null);
        },
        // backgroundColor: Colors.blue,
      ),
    );
  }
}
