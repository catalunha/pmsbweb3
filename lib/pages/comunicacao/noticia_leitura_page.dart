import 'package:flutter_web/material.dart';
// import 'package:flutter_web_markdown/flutter_web_markdown.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/components/default_scaffold.dart';
import 'package:pmsbweb/models/noticia_model.dart';
import 'package:pmsbweb/pages/comunicacao/noticia_page_bloc.dart';

class NoticiaLeituraPage extends StatelessWidget {
  final bloc = NoticiaPageBloc(
      firestore: Bootstrap.instance.firestore, visualizada: false);
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: StreamBuilder<NoticiaPageState>(
        stream: bloc.noticiaPageStateStream,
        builder: (context, snap) {
          if (snap.hasError) {
            return Text("ERROR");
          }
          if (!snap.hasData) {
            return Text("Buscando usuario...");
          }
          return Text("Oi ${snap.data?.usuarioIDNome}");
        },
      ),
      // body: Text('oi')
      body: Container(
        child: StreamBuilder<List<NoticiaModel>>(
            stream: bloc.noticiaModelListStream,
            initialData: [],
            builder: (context, snapshot) {
              return Center(
                child: Text(
                  "Bem vindo !",
                  style: Theme.of(context).textTheme.display1,
                ),
              );
              // if (snapshot.hasError) {
              //   return Center(
              //     child: Text("Erro. Na leitura de noticias do usuario."),
              //   );
              // }
              // if (!snapshot.hasData) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              // return ListView(
              //   children: snapshot.data.map((noticia) {
              //     return Card(
              //       child: Column(
              //         children: <Widget>[
              //           ListTile(
              //             title: Text('Titulo ${noticia?.titulo}'),
              //             subtitle: Text(
              //                 "Editor: ${noticia.usuarioIDEditor.nome}\nem: ${noticia.publicar}\n"),
              //             trailing: IconButton(
              //               icon: Icon(bloc.visualizada
              //                   ? Icons.arrow_back
              //                   : Icons.arrow_forward),
              //               onPressed: () {
              //                 bloc.noticiaPageEventSink(
              //                     UpdateNoticiaVisualizadaEvent(
              //                         noticiaID: noticia.id));
              //               },
              //             ),
              //           ),
              //           ListTile(
              //             // title: MarkdownBody(
              //             //   data: "${noticia.textoMarkdown}",
              //             // ),
              //           ),

              //         ],
              //       ),
              //     );

              //   }).toList(),
              // );
            }),
      ),
    );
  }
}

// import 'package:simple_permissions/simple_permissions.dart';

// class NoticiaLeituraPage extends StatefulWidget {
//   NoticiaLeituraPage({Key key}) : super(key: key);

//   _NoticiaLeituraPageState createState() => _NoticiaLeituraPageState();
// }

// class _NoticiaLeituraPageState extends State<NoticiaLeituraPage> {
//   @override
//   void initState() {
//     super.initState();

//     requestPermission();
//   }

//   requestPermission() async {
//     final res = await SimplePermissions.requestPermission(
//         Permission.WriteExternalStorage);
//     print("permission request result is " + res.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultScaffold(
//       title: Text('teste'),
//       body: Text('oi'),
//     );
//   }
// }
