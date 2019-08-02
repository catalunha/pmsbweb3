import 'package:flutter_web/material.dart';
import 'package:pmsbweb/models/questionario_model.dart';

class QuestionarioNome extends StatelessWidget {
  final QuestionarioModel _questionario;

  QuestionarioNome(this._questionario);

  @override
  Widget build(BuildContext context) {
    var pretext = "Questionario - ";
    if (_questionario.nome == null) return Text("$pretext ");
    return Text("$pretext ${_questionario.nome}");
  }
}
