// import 'package:flutter_web/material.dart';
// import 'package:pmsbweb/bootstrap.dart';
// import 'package:pmsbweb/pages/pergunta/editar_apagar_pergunta_page_bloc.dart';
// import 'package:pmsbweb/pages/pergunta/selecionar_requisito_pergunta_page_bloc.dart';
// import 'package:pmsbweb/state/auth_bloc.dart';

// class SelecionarQuequisitoPerguntaPage extends StatelessWidget {
//   final AuthBloc authBloc;
//   final EditarApagarPerguntaBloc blocPergunta;
//   final SelecionarRequisitoPerguntaPageBloc bloc;

//   SelecionarQuequisitoPerguntaPage(this.authBloc, this.blocPergunta)
//       : bloc = SelecionarRequisitoPerguntaPageBloc(
//             Bootstrap.instance.firestore, authBloc, blocPergunta);

//   Widget _body() {
//     return StreamBuilder<SelecionarRequisitoPerguntaPageBlocState>(
//       stream: bloc.state,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text("ERROR");
//         }
//         if (!snapshot.hasData) {
//           return Text("SEM DADOS");
//         }

//         final requisitos =
//             snapshot.data.requisitos != null ? snapshot.data.requisitos : {};

//         final widgetRequisitos = requisitos.map(
//           (i, e) {
//             return MapEntry(
//               i,
//               Card(
//                 child: CheckboxListTile(
//                   value: e['checkbox'],
//                   title: new Text('${e['questionario']}\n${e['pergunta']}'),
//                   // subtitle: Text('${e['questionario']}'),
//                   controlAffinity: ListTileControlAffinity.trailing,
//                   onChanged: (bool val) {
//                     bloc.dispatch(
//                         IndexSelecionarRequisitoPerguntaPageBlocEvent(i, val));
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//         return ListView(
//           children: [
//             ...widgetRequisitos.values.toList(),
//             Container(
//               padding: EdgeInsets.only(top: 75),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Colors.red,
//           automaticallyImplyLeading: true,
//           title: Text('Selecionar Requisitos'),
//         ),
//         floatingActionButton:
//             StreamBuilder<SelecionarRequisitoPerguntaPageBlocState>(
//                 stream: bloc.state,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text("ERROR");
//                   }
//                   if (!snapshot.hasData) {
//                     return Text("SEM DADOS");
//                   }
//                   return FloatingActionButton(
//                     onPressed: () {
//                       bloc.dispatch(
//                           UpdateRequisitosSelecionarRequisitoPerguntaPageBlocEvent());
//                       // Navigator.pushNamed(
//                       //                   context, "/pergunta/pergunta_requisito_marcado",
//                       //                   arguments: snapshot.data.perguntaID);

//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.thumb_up),
//                   );
//                 }),
//         body: _body());
//   }
// }
