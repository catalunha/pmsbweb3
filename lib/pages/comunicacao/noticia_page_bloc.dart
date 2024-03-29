// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsbweb/api/auth_api_mobile.dart';
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/models/usuario_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pmsbweb/models/noticia_model.dart';
import 'package:firestore_wrapper/firestore_wrapper.dart' as fsw;
import 'package:pmsbweb/state/auth_bloc.dart';

class NoticiaPageEvent {}

class UpdateUsuarioIDEvent extends NoticiaPageEvent {
  final String usuarioID;

  UpdateUsuarioIDEvent(this.usuarioID);
}

class UpdateNoticiaVisualizadaEvent extends NoticiaPageEvent {
  final String noticiaID;
  final String usuarioID;

  UpdateNoticiaVisualizadaEvent({this.noticiaID, this.usuarioID});
}

class NoticiaPageState {
  String usuarioID;
  String usuarioIDNome;
  String noticiaID;
}

class NoticiaPageBloc {
  final bool visualizada;
  // Database
  final fsw.Firestore firestore;

  // Authenticacação
  final _authBloc = Bootstrap.instance.authBloc;

  //Evento
  final _noticiaPageEventController = BehaviorSubject<NoticiaPageEvent>();
  Stream<NoticiaPageEvent> get noticiaPageEventStream =>
      _noticiaPageEventController.stream;
  Function get noticiaPageEventSink => _noticiaPageEventController.sink.add;

  //Estado
  final _noticiaPageState = NoticiaPageState();
  final _noticiaPageStateController = BehaviorSubject<NoticiaPageState>();
  Stream<NoticiaPageState> get noticiaPageStateStream =>
      _noticiaPageStateController.stream;
  Function get noticiaPageStateSink => _noticiaPageStateController.sink.add;

  // //UsuarioNoticiaModel
  // final _usuarioNoticiaModelListController =
  //     BehaviorSubject<List<UsuarioNoticiaModel>>();
  // Stream<List<UsuarioNoticiaModel>> get usuarioNoticiaModelListStream =>
  //     _usuarioNoticiaModelListController.stream;
  // Function get usuarioNoticiaModelListSink =>
  //     _usuarioNoticiaModelListController.sink.add;

  //NoticiaModel
  final _noticiaModelListController = BehaviorSubject<List<NoticiaModel>>();
  Stream<List<NoticiaModel>> get noticiaModelListStream =>
      _noticiaModelListController.stream;
  Function get noticiaModelListSink => _noticiaModelListController.sink.add;

  NoticiaPageBloc({this.firestore, this.visualizada}) {

    noticiaPageEventStream.listen(_mapEventToState);
    _authBloc.userId
        .listen((userId) => noticiaPageEventSink(UpdateUsuarioIDEvent(userId)));
  }
  void dispose() {
    _noticiaPageEventController.close();
    _noticiaPageStateController.close();
    // _usuarioNoticiaModelListController.close();
    _noticiaModelListController.close();
  }

  void _mapEventToState(NoticiaPageEvent event) {
    if (event is UpdateUsuarioIDEvent) {
      _noticiaPageState.usuarioID = event.usuarioID;
      firestore
          .collection(UsuarioModel.collection)
          .document(_noticiaPageState.usuarioID)
          .snapshots()
          .map((snap) => UsuarioModel(id: snap.documentID).fromMap(snap.data))
          .listen((usuario) {
        _noticiaPageState.usuarioIDNome = usuario.nome;
        // print('>> usuario.nome >> ${usuario.nome}');
        noticiaPageStateSink(_noticiaPageState);
      });
      noticiaPageStateStream.listen((event) {
        // print('>> event >> ${event.usuarioID}');
        // print('>> event >> ${event.usuarioIDNome}');
      });
      firestore
          .collection(NoticiaModel.collection)
          .where("usuarioIDDestino.${_noticiaPageState.usuarioID}.id",
              isEqualTo: true)
          .where("usuarioIDDestino.${_noticiaPageState.usuarioID}.visualizada",
              isEqualTo: visualizada)
          // .where("usuarioIDDestino.${_noticiaPageState.usuarioID}.publicar",
          //     isGreaterThanOrEqualTo: DateTime.now())
          .snapshots()
          .map((snap) => snap.documents
              .map((doc) => NoticiaModel(id: doc.documentID).fromMap(doc.data))
              .toList())
          .pipe(_noticiaModelListController);
      noticiaModelListStream.listen((noticia) {
        noticia.forEach((item) {
          // print('>> item. >> ${item.titulo}');
          // print('>> item. >> ${item.publicar}');
          // print('>> item. >> ${item.publicada}');
        });
      });
    }
    if (event is UpdateNoticiaVisualizadaEvent) {
      _noticiaPageState.noticiaID = event.noticiaID;
      noticiaPageStateSink(_noticiaPageState);

      print('usuarioIDDestino.${_noticiaPageState.usuarioID}.visualizada');
      firestore
          .collection(NoticiaModel.collection)
          .document(_noticiaPageState.noticiaID)
          .setData({
        "usuarioIDDestino": {
          "${_noticiaPageState.usuarioID}": {"visualizada": !visualizada}
        }
      }, merge: true);
    }

    // noticiaPageStateSink(_noticiaPageState);
  }
}
