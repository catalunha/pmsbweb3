import 'package:flutter_web/material.dart';
import 'package:pmsbweb/bootstrap.dart';
// import 'package:pmsbweb/components/eixo.dart';
import 'package:pmsbweb/pages/pages.dart';
import 'package:firebase/firebase.dart';
import 'package:pmsbweb/pages/questionario/pergunta_list_preview_page.dart';


void main() {
  initializeApp(
    apiKey: "AIzaSyCKI8cjlLhrl2OXNhcPgjhky8k1xEXAquM",
    authDomain: "pmsb-22-to.firebaseapp.com",
    databaseURL: "https://pmsb-22-to.firebaseio.com",
    projectId: "pmsb-22-to",
    storageBucket: "pmsb-22-to.appspot.com",
    messagingSenderId: "167336774894",
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = Bootstrap.instance.authBloc;
    return 
    // Provider.value(
    //   value: authBloc,
    //   child: Provider<DatabaseService>.value(
    //     value: DatabaseService(),
    //     child: 
        MaterialApp(
          title: 'PMSB',
          //theme: ThemeData.dark(),
          //initialRoute: "/",
          initialRoute: "/",
          routes: {
            //homePage
            "/": (context) => HomePage(authBloc),

            // //Desenvolvimento
            // "/desenvolvimento": (context) => Desenvolvimento(),

            // //upload
            // "/upload": (context) => UploadPage(authBloc),

            //perfil
            "/perfil": (context) => PerfilPage(),
            "/perfil/configuracao": (context) => ConfiguracaoPage(authBloc),
            "/perfil/crudtext": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerfilCRUDPage(settings.arguments);
            },
            "/perfil/crudarq": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerfilCRUDArqPage(settings.arguments);
            },

            //questionario
            "/questionario/home": (context) => QuestionarioHomePage(authBloc),
            "/questionario/form": (context) => QuestionarioFormPage(
              authBloc,
              ModalRoute.of(context).settings.arguments,
            ),
        "/pergunta/pergunta_list_preview": (context) {
          final settings = ModalRoute.of(context).settings;
          return PerguntaListPreviewPage(questionarioID: settings.arguments);
        },
        
            //pergunta
            "/pergunta/home": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerguntaHomePage(settings.arguments);
            },
            "/pergunta/criar_pergunta": (context) => CriarPerguntaTipoPage(),
            "/pergunta/criar_editar": (context) {
              final settings = ModalRoute.of(context).settings;
              final EditarApagarPerguntaPageArguments args = settings.arguments;
              return EditarApagarPerguntaPage(
                questionarioID: args.questionarioID,
                perguntaID: args.perguntaID,
              );
            },
            // "/pergunta/selecionar_requisito": (context) {
            //   final settings = ModalRoute.of(context).settings;
            //   return SelecionarQuequisitoPerguntaPage(
            //       authBloc, settings.arguments);
            // },
            // "/pergunta/criar_ordenar_escolha": (context) {
            //   final settings = ModalRoute.of(context).settings;
            //   return CriarOrdenarEscolha(settings.arguments);
            // },
            // "/pergunta/editar_apagar_escolha": (context) {
            //   final settings = ModalRoute.of(context).settings;
            //   final EditarApagarEscolhaPageArguments args = settings.arguments;
            //   return EditarApagarEscolhaPage(args.bloc, args.escolhaID);
            // },
            //Pergunta Acrescimos Prof Catalunha
            "/pergunta/escolha_list": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerguntaEscolhaListPage(settings.arguments);
            },
            "/pergunta/escolha_crud": (context) {
              final settings = ModalRoute.of(context).settings;
              final PerguntaIDEscolhaIDPageArguments args = settings.arguments;
              return PerguntaEscolhaCRUDPage(args.perguntaID, args.escolhaUID);
            },
            "/pergunta/pergunta_preview": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerguntaPreviewPage(perguntaID: settings.arguments);
            },
            "/pergunta/pergunta_requisito_marcar": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerguntaRequisitoEscolhaMarcarPage(
                  perguntaID: settings.arguments);
            },
            "/pergunta/pergunta_requisito": (context) {
              final settings = ModalRoute.of(context).settings;
              return PerguntaRequisitoPage(
                  perguntaID: settings.arguments);
            },

            //aplicacao
            // "/aplicacao/home": (context) => AplicacaoHomePage(),
            // "/aplicacao/momento_aplicacao": (context) => MomentoAplicacaoPage(),
            // "/aplicacao/aplicando_pergunta": (context) =>
            //     AplicacaoPerguntaPage(),
            // "/aplicacao/pendencias": (context) => PendenciasPage(),
            // "/aplicacao/visualizar_respostas": (context) =>
            //     VisualizarRespostasPage(),
            // "/aplicacao/definir_requisitos": (context) =>
            //     DefinirRequisistosPage(),

            //resposta
            "/resposta/home": (context) => RespostaHomePage(),
            "/resposta/resposta_questionario": (context) =>
                RespostaQuestionarioPage(),
            "/resposta/questionario_resposta": (context) =>
                QuestionarioRespostaPage(),

            //sintese
            "/sintese/home": (context) => SinteseHomePage(),

            //produto
            "/produto/home": (context) => ProdutoHomePage(authBloc),
            "/produto/crud": (context) {
              final settings = ModalRoute.of(context).settings;
              return ProdutoCRUDPage(settings.arguments, authBloc);
            },            

            //comunicacao
            "/comunicacao/home": (context) => ComunicacaoHomePage(),
            "/noticias/noticias_visualizadas": (context) => NoticiaLidaPage(),
            "/comunicacao/crud_page": (context) => ComunicacaoCRUDPage(),

            //administração
            "/administracao/home": (context) => AdministracaoHomePage(),
            "/administracao/perfil": (context) => AdministracaoPerfilPage(),

            //controle
            "/controle/home": (context) => ControleHomePage(),
          },
      //   ),
      // ),
    );
  }
}
