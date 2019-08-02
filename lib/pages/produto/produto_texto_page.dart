import 'package:flutter_web/material.dart';
// import 'package:flutter_web_markdown/flutter_web_markdown.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/pages/produto/produto_texto_page_bloc.dart';

class ProdutoTextoPage extends StatefulWidget {
  final String produtoID;

  ProdutoTextoPage(this.produtoID);

  @override
  State<StatefulWidget> createState() {
    return _ProdutoTextoPageState();
  }
}

class _ProdutoTextoPageState extends State<ProdutoTextoPage> {
  String textoMarkdownLocal;
  final bloc = ProdutoTextoPageBloc(Bootstrap.instance.firestore);

  @override
  void initState() {
    super.initState();
    bloc.eventSink(UpdateProdutoIDEvent(widget.produtoID));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:
        //  Provider<ProdutoTextoPageBloc>.value(
        //     value: bloc,
        //     child: 
            Scaffold(
              appBar: AppBar(
                title: Text("Editar texto do produto"),
                // backgroundColor: Colors.red,
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Preview"),
                    Tab(text: "Texto"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // Tab(text: "Dados"),
                  _bodyPreview(context),
                  UpDateProdutoIDTexto(bloc),

                  // ViewProdutoIDTexto(),
                  // _bodyTexto(),
                  // _bodyPreview(context)
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save_alt),
                onPressed: () {
                  Navigator.of(context).pop();
                  bloc.eventSink(SaveProdutoTextoIDTextoEvent());

                  // Navigator.pushNamed(context, '/produto/crud_texto');
                },
                // backgroundColor: Colors.blue,
              ),
            // )
            ));
  }

  _bodyPreview(context) {
    return StreamBuilder<ProdutoTextoPageState>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
          //   myController.text = snapshot.data.produtoTextoIDTextoMarkdown;
          // }
          if (!snapshot.hasData) {
            return Text('Sem dados');
          }
          //TODO: inserir a exibicao de markdown correta
          return Container();//Markdown(data: snapshot.data.produtoTextoIDTextoMarkdown);
        });
  }
}

class UpDateProdutoIDTexto extends StatefulWidget {
  final ProdutoTextoPageBloc bloc;
  UpDateProdutoIDTexto(this.bloc);
  @override
  State<StatefulWidget> createState() {
    return UpDateProdutoIDTextoState(bloc);
  }
}

class UpDateProdutoIDTextoState extends State<UpDateProdutoIDTexto> {
  final _controller = TextEditingController();
final ProdutoTextoPageBloc bloc;
UpDateProdutoIDTextoState(this.bloc);
  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of<ProdutoTextoPageBloc>(context);
    return StreamBuilder<ProdutoTextoPageState>(
        stream: bloc.stateStream,
        builder: (BuildContext context,
            AsyncSnapshot<ProdutoTextoPageState> snapshot) {
          if (_controller.text == null || _controller.text.isEmpty) {
            _controller.text = snapshot.data?.produtoTextoIDTextoMarkdown;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text("Atualizar nome no produto"),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _controller,
                onChanged: (produtoTexto) {
                  bloc.eventSink(UpdateProdutoTextoIDTextoEvent(produtoTexto));
                },
              ),
            ],
          );
        });
  }
}
