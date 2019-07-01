import 'dart:html' as prefix0;
import 'package:flutter_web/material.dart';
import 'package:pmsbweb/components/default_scaffold.dart';

class ControleHomePage extends StatefulWidget {
  @override
  _ControleHomePageState createState() => _ControleHomePageState();
}

class _ControleHomePageState extends State<ControleHomePage> {
  var _index = 0;
  _body() {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(30)),
                Text(
                  "Aplicativo: Controle",
                  style: Theme.of(context).textTheme.display1,
                ),
                Padding(padding: EdgeInsets.all(10)),
                Image.asset(
                  "images/construcao.png",
                  width: 600,
                ),
                Text(
                  "Prévia...",
                  style: Theme.of(context).textTheme.display1,
                ),
                Stepper(
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Row(
                      children: <Widget>[

                      ],
                    );
                  },
                  steps: const <Step>[
                    Step(
                      title: Text("Preparação Fisica"),
                      subtitle: Text("Equipamentos, ... "),
                      content: Text("EPIs, Sensores, Veiculos, ..."),
                    ),
                    Step(
                        title: Text("Preparação Administrativa"),
                        subtitle: Text("Questionários,..."),
                        content: Text(
                            "Definição das perguntas, Autorizações Prefeitura,..."),
                        state: StepState.editing,
                        isActive: true),
                    Step(
                        title: Text("Agenda e Rota"),
                        subtitle: Text("Datas, ..."),
                        content: Text("Equipe, Datas, Locais, Hospedagem, ..."),
                        state: StepState.error),
                    Step(
                        title: Text("Campo"),
                        subtitle: Text("Local X, Mapas google, "),
                        content: Text(
                            "Contatos, Deslocamentos, Alimentação, Manutenção,..."),
                        state: StepState.complete),
                    Step(
                        title: Text("Análise"),
                        subtitle: Text("Sintese Aplicativo, Planilhas "),
                        content: Text("Fotos, Graficos, Tabelas, Textos,...."),
                        state: StepState.indexed),
                    Step(
                        title: Text("Previa"),
                        subtitle: Text("Editando Produto, ..."),
                        content:
                            Text("Reuniões, Comunicações, Integrações,..."),
                        state: StepState.indexed),
                    Step(
                        title: Text("Produto"),
                        subtitle: Text("Diagramação, ..."),
                        content: Text(
                            "Reconfigurações, Projeções, Apresentações,..."),
                        state: StepState.complete),
                  ],
                  currentStep: _index,
                  onStepTapped: (index) {
                    setState(() {
                      _index = index;
                    });
                  },
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: Text("Controle"),
      body: _body(),
    );
  }
}
