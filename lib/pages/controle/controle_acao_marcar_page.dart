import 'dart:html' as html;

import 'package:flutter_web/material.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/pages/controle/controle_acao_marcar_bloc.dart';
import 'package:pmsbweb/pages/page_arguments.dart';

class ControleAcaoMarcarPage extends StatefulWidget {
  final String controleTarefaID;

  const ControleAcaoMarcarPage(this.controleTarefaID);

  @override
  _ControleAcaoMarcarPageState createState() => _ControleAcaoMarcarPageState();
}

class _ControleAcaoMarcarPageState extends State<ControleAcaoMarcarPage> {
  ControleAcaoMarcarBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ControleAcaoMarcarBloc(Bootstrap.instance.firestore);
    bloc.eventSink(UpdateTarefaIDEvent(widget.controleTarefaID));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  _bodyDestinatario(context) {
    return StreamBuilder<ControleAcaoMarcarBlocState>(
      stream: bloc.stateStream,
      builder: (BuildContext context,
          AsyncSnapshot<ControleAcaoMarcarBlocState> snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR");
        }
        if (!snapshot.hasData) {
          return Text("SEM DADOS");
        }
        if (snapshot.hasData) {
          if (snapshot.data.isDataValid) {
            List<Widget> listaWdg = List<Widget>();
            List<Widget> listaWdgLink = List<Widget>();
            int ordemLocal = 1;

            for (var controleAcaoID in snapshot.data.controleAcaoList) {
              listaWdgLink.clear();
              if (controleAcaoID.tarefaLink != null) {
                for (var item in controleAcaoID.tarefaLink.entries) {
                  //print(item.key);
                  listaWdgLink.add(IconButton(
                    tooltip: 'Ver tarefa linkada id: ${item.key}',
                    icon: Icon(Icons.link),
                    onPressed: () async {
                      Navigator.pushNamed(
                        context,
                        "/controle/acao_concluida",
                        arguments: item.key,
                      );
                    },
                  ));
                }
                // controleAcaoID.tarefaLink.map((k, v) {
                //   // listaWdgLink.add(IconButton(
                //   //   tooltip: 'Ver tarefa linkada a esta ação',
                //   //   icon: Icon(Icons.link),
                //   //   onPressed: () async {
                //   //     Navigator.pushNamed(
                //   //       context,
                //   //       "/controle/acao_concluida",
                //   //       arguments: k,
                //   //     );
                //   //   },
                //   // ));
                //   //print(k);
                // });
              }
              listaWdg.add(Column(children: <Widget>[
                ListTile(
                    selected: controleAcaoID.concluida,
                    trailing: controleAcaoID.concluida
                        ? Text('*  ${ordemLocal}')
                        : Text('${ordemLocal}'),
                    title: Text('${controleAcaoID.nome}'),
                    subtitle: Text(
                        'Obs: ${controleAcaoID.observacao}\nAtualizada: ${controleAcaoID.modificada}\nid: ${controleAcaoID.id}')),
                Wrap(alignment: WrapAlignment.center, children: <Widget>[
                  IconButton(
                    tooltip: 'Criar uma tarefa desta ação',
                    icon: Icon(Icons.assignment_turned_in),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/controle/tarefa_crud",
                        arguments: ControlePageArguments(
                            tarefa: null,
                            acao: controleAcaoID.id,
                            acaoNome: controleAcaoID.nome),
                      );
                    },
                  ),
                  ...listaWdgLink,
                  controleAcaoID.url != null && controleAcaoID.url != ''
                      ? IconButton(
                          tooltip: 'Ver arquivo',
                          icon: Icon(Icons.cloud),
                          onPressed: () {
                            // launch(controleAcaoID.url);
                            html.window.open(controleAcaoID.url, "name");
                          },
                        )
                      : Text(''),
                  IconButton(
                    tooltip: 'Editar Url e Observações',
                    icon: Icon(Icons.note_add),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/controle/acao_informar_urlobs',
                          arguments: controleAcaoID.id);
                    },
                  ),
                  IconButton(
                    tooltip: 'Marcar como feita.',
                    icon: controleAcaoID.concluida
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank),
                    onPressed: () {
                      bloc.eventSink(UpdateAcaoEvent(
                          controleAcaoID.id, controleAcaoID.concluida));
                    },
                  ),
                ])
              ]));
              ordemLocal++;
            }
            // //print(listaWdg.toString());
            var controleTarefaID = snapshot.data.controleTarefaDestinatario;
            return Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 10,
                      child: Text(
                          'Setor: ${controleTarefaID?.setor?.nome}\nNome: ${controleTarefaID?.nome}\nDe: ${controleTarefaID?.remetente?.nome}\nInicio: ${controleTarefaID?.inicio}\nFim: ${controleTarefaID?.fim}\nAtualizada: ${controleTarefaID?.modificada}\nid: ${controleTarefaID?.id}\nConcluida: ${controleTarefaID?.acaoCumprida} de ${controleTarefaID?.acaoTotal}')),
                ],
              ),
              Divider(),
              Expanded(
                flex: 10,
                child: ListView(
                  children: listaWdg,
                ),
              )
            ]);
          } else {
            return Text('Existem dados inválidos...');
          }
          // return Text("listando acao...");
        }
        return Text("Algo não esta certo...");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcar ação'),
      ),
      body: _bodyDestinatario(context),

      // ),
    );
  }
}