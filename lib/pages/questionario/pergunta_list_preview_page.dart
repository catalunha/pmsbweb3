

import 'package:flutter_web/material.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/pages/markdown/src/widget.dart';
import 'package:pmsbweb/pages/questionario/pergunta_list_preview_bloc.dart';

class PerguntaListPreviewPage extends StatelessWidget {
  final String questionarioID;
  final PerguntaListPreviewBloc bloc;

  PerguntaListPreviewPage({this.questionarioID})
      : bloc = PerguntaListPreviewBloc(Bootstrap.instance.firestore) {
    bloc.eventSink(UpdateQuestionarioIDEvent(questionarioId: questionarioID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visão geral da pergunta'),
      ),
      body: _bodyPreview(),
    );
  }

  _bodyPreview() {
    return StreamBuilder<PerguntaListPreviewPageState>(
        stream: bloc.stateStream,
        builder: (BuildContext context,
            AsyncSnapshot<PerguntaListPreviewPageState> snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR");
          }
          if (!snapshot.hasData) {
            return Text("SEM DADOS");
          }
print(snapshot.data.questionarioPerguntaList2Mkd);
            return MarkdownBody(data: snapshot.data.questionarioPerguntaList2Mkd);

        });
  }
}
