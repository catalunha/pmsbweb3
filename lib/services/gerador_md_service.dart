import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/models/models.dart';
import 'package:firestore_wrapper/firestore_wrapper.dart' as fsw;
import 'package:queries/collections.dart';

class GeradorMdService {
  static generateMdFromUsuarioModel(UsuarioModel usuarioModel) {
    return """
${usuarioModel.nome}
====================================================

![alt text](${usuarioModel.foto.url})

### Id: ${usuarioModel.id}
### Celular: ${usuarioModel.celular}
### Email: ${usuarioModel.email}
### Eixo: ${usuarioModel.eixoID.nome}

## Perfil em construção
""";
  }

  static generateMdFromNoticiaModelList(List<NoticiaModel> noticiaModelList) {
    String texto = '';
    noticiaModelList.forEach((noticia) {
      texto += """
# Noticias  Publicadas

## ${noticia.titulo}
id: ${noticia.id}

${noticia.textoMarkdown}

---
""";
    });
    return texto;
  }

  static generateMdFromQuestionarioModel(
      QuestionarioModel questionarioModel) async {
    final fsw.Firestore _firestore = Bootstrap.instance.firestore;
    StringBuffer texto = new StringBuffer();
    StringBuffer escolhaList = new StringBuffer();
    StringBuffer requisitoList = new StringBuffer();
    int contador = 1;

    texto.writeln("""
# ${questionarioModel.nome}

Último editor: ${questionarioModel.editou.nome}

Uso do sistema: Questionário id: ${questionarioModel.id}

Lista de perguntas: 

---
""");
    final perguntasRef = _firestore
        .collection(PerguntaModel.collection)
        .where("questionario.id", isEqualTo: questionarioModel.id)
        .orderBy("ordem", descending: false);

    final fsw.QuerySnapshot perguntasSnapshot =
        await perguntasRef.getDocuments();
    final perguntasList =
        perguntasSnapshot.documents.map((fsw.DocumentSnapshot doc) {
      return PerguntaModel(id: doc.documentID).fromMap(doc.data);
    }).toList();

    // perguntasList.forEach((pergunta) {
    for (var pergunta in perguntasList) {
      escolhaList.clear();
      requisitoList.clear();

      // +++ escolhas
      escolhaList.clear();
      if (pergunta.tipo.id == 'escolhaunica' ||
          pergunta.tipo.id == 'escolhamultipla') {
        if (pergunta.escolhas != null && pergunta.escolhas.isNotEmpty) {
          var dicEscolhas = Dictionary.fromMap(pergunta.escolhas);
          var escolhasAscOrder = dicEscolhas
              // Sort Ascending order by value ordem
              .orderBy((kv) => kv.value.ordem)
              // Sort Descending order by value ordem
              // .orderByDescending((kv) => kv.value.ordem)
              .toDictionary$1((kv) => kv.key, (kv) => kv.value);
          print(escolhasAscOrder.toMap());
          Map<String, Escolha> escolhaMap = escolhasAscOrder.toMap();
          escolhaList.writeln("#### ${pergunta.tipo.nome}");
          escolhaMap?.forEach((k, v) {
            escolhaList.writeln("""
1. **${v.texto}**
""");
          });
        }
      }
      // --- escolhas

      //+++ requisitos
      requisitoList.clear();
      if (pergunta.requisitos != null && pergunta.requisitos.isNotEmpty) {
        requisitoList.writeln("#### Requisitos");
        for (var perguntaRequisito in pergunta.requisitos.values) {
          if (perguntaRequisito.label != null) {
            requisitoList.writeln("""
- ${perguntaRequisito.label}.
            """);
          }
          if (perguntaRequisito.escolha != null) {
            requisitoList.writeln("""
- ${perguntaRequisito.escolha.label} (${perguntaRequisito.escolha.marcada}).
            """);
          }
        }
      }
      //--- requisitos

      texto.writeln("""
## ${contador} - ${pergunta.titulo}

### ${pergunta.textoMarkdown}

${escolhaList}

${requisitoList}


Uso do sistema: Pergunta Tipo: ${pergunta.tipo.nome}. Pergunta id: ${pergunta.id}

-----

""");
      contador++;
    } //Fim pergunta
    return texto.toString();
  }
}